import AppKit
import SwiftUI
import Combine

/// 窗口服务
@MainActor
class WindowService: ObservableObject {
    static let shared = WindowService()

    private var mainWindow: NSWindow?
    private var noteService: NoteService

    // MARK: - Initialization

    private init(noteService: NoteService = .shared) {
        self.noteService = noteService
    }

    // MARK: - Public Methods

    /// 创建主窗口
    func createMainWindow() -> NSWindow {
        let window = NSWindow(
            contentRect: NSRect(
                x: Constants.Window.defaultPosition.x,
                y: Constants.Window.defaultPosition.y,
                width: Constants.Window.defaultWidth,
                height: Constants.Window.defaultHeight
            ),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )

        // 设置窗口属性
        window.title = "QuickNote Clone"
        window.level = .floating
        window.isReleasedWhenClosed = false
        window.isMovableByWindowBackground = true
        window.center()

        // 设置窗口最小/最大尺寸
        window.minSize = NSSize(
            width: Constants.Window.minWidth,
            height: Constants.Window.minHeight
        )
        window.maxSize = NSSize(
            width: Constants.Window.maxWidth,
            height: Constants.Window.maxHeight
        )

        // 恢复窗口位置和大小
        Task {
            await restoreWindowPositionAndSize(window)
        }

        // 监听窗口变化
        setupWindowObservers(window)

        self.mainWindow = window
        return window
    }

    /// 切换窗口置顶状态
    func toggleAlwaysOnTop() {
        guard let window = mainWindow else { return }

        if window.level == .floating {
            window.level = .normal
        } else {
            window.level = .floating
        }

        // 保存设置
        Task {
            var settings = await noteService.getSettings()
            settings.isAlwaysOnTop = (window.level == .floating)
            try? await noteService.saveSettings(settings)
        }
    }

    /// 设置窗口置顶状态
    func setAlwaysOnTop(_ alwaysOnTop: Bool) {
        mainWindow?.level = alwaysOnTop ? .floating : .normal
    }

    /// 显示窗口
    func showWindow() {
        guard let window = mainWindow else { return }

        if window.isMiniaturized {
            window.deminiaturize(nil)
        }

        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    /// 隐藏窗口
    func hideWindow() {
        mainWindow?.orderOut(nil)
    }

    /// 最小化窗口
    func minimizeWindow() {
        mainWindow?.miniaturize(nil)
    }

    // MARK: - Private Methods

    private func setupWindowObservers(_ window: NSWindow) {
        // 监听窗口移动
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(windowDidMove(_:)),
            name: NSWindow.didMoveNotification,
            object: window
        )

        // 监听窗口大小变化
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(windowDidResize(_:)),
            name: NSWindow.didResizeNotification,
            object: window
        )
    }

    @objc private func windowDidMove(_ notification: Notification) {
        guard let window = mainWindow else { return }

        // 保存窗口位置
        Task {
            await saveWindowPositionAndSize(window)
        }
    }

    @objc private func windowDidResize(_ notification: Notification) {
        guard let window = mainWindow else { return }

        // 保存窗口大小
        Task {
            await saveWindowPositionAndSize(window)
        }
    }

    private func saveWindowPositionAndSize(_ window: NSWindow) async {
        var settings = await noteService.getSettings()
        settings.windowPosition = CGPoint(x: window.frame.origin.x, y: window.frame.origin.y)
        settings.windowSize = CGSize(width: window.frame.width, height: window.frame.height)
        try? await noteService.saveSettings(settings)
    }

    private func restoreWindowPositionAndSize(_ window: NSWindow) async {
        let settings = await noteService.getSettings()

        // 检查窗口位置是否在屏幕范围内
        let screenFrame = NSScreen.main?.visibleFrame ?? NSRect.zero
        var position = settings.windowPosition
        var size = settings.windowSize

        // 如果窗口位置超出屏幕,使用默认位置
        if position.x < screenFrame.minX || position.x > screenFrame.maxX ||
           position.y < screenFrame.minY || position.y > screenFrame.maxY {
            position = Constants.Window.defaultPosition
        }

        // 如果窗口大小超出限制,使用默认大小
        if size.width < Constants.Window.minWidth || size.width > Constants.Window.maxWidth ||
           size.height < Constants.Window.minHeight || size.height > Constants.Window.maxHeight {
            size = CGSize(
                width: Constants.Window.defaultWidth,
                height: Constants.Window.defaultHeight
            )
        }

        // 设置窗口位置和大小
        window.setFrame(
            NSRect(origin: position, size: size),
            display: true
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

/// 窗口包装器(用于 SwiftUI)
struct WindowWrapper<Content: View>: NSViewRepresentable {
    let content: Content
    @Binding var isAlwaysOnTop: Bool

    func makeNSView(context: Context) -> NSView {
        let view = NSView()

        DispatchQueue.main.async {
            if let window = view.window {
                window.level = isAlwaysOnTop ? .floating : .normal
            }
        }

        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        DispatchQueue.main.async {
            if let window = nsView.window {
                window.level = isAlwaysOnTop ? .floating : .normal
            }
        }
    }
}
