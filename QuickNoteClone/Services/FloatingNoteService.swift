import AppKit
import SwiftUI

/// 悬浮便签服务
@MainActor
class FloatingNoteService {
    static let shared = FloatingNoteService()

    private var floatingWindows: [UUID: NSWindow] = [:]
    private var windowOrder: [UUID] = []  // 保持窗口顺序
    private let windowWidth: CGFloat = 280
    private let windowHeight: CGFloat = 400
    private let windowSpacing: CGFloat = 20

    private init() {}

    /// 显示悬浮便签窗口
    func showFloatingNote(_ note: Note, onUpdate: @escaping (Note) -> Void, onClose: @escaping () -> Void = {}) {
        // 如果窗口已存在,显示它
        if let window = floatingWindows[note.id] {
            window.makeKeyAndOrderFront(nil)
            return
        }

        // 创建新窗口（无边框样式）
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: windowWidth, height: windowHeight),
            styleMask: [.borderless, .resizable],
            backing: .buffered,
            defer: false
        )

        window.title = note.title
        window.level = .floating
        window.isReleasedWhenClosed = false
        window.isMovableByWindowBackground = true
        window.backgroundColor = .clear
        window.minSize = NSSize(width: windowWidth, height: windowHeight)
        window.maxSize = NSSize(width: windowWidth, height: windowHeight)

        // 设置窗口内容，使用 Binding
        let contentView = FloatingNoteView(
            note: Binding(
                get: { note },
                set: { newValue in
                    onUpdate(newValue)
                }
            ),
            onUpdate: onUpdate,
            onClose: onClose
        )
        window.contentViewController = NSHostingController(rootView: contentView)

        // 计算窗口位置
        var newFrame: NSRect

        if let lastNoteId = windowOrder.last, let lastWindow = floatingWindows[lastNoteId] {
            // 如果有已有窗口，放在最后一个窗口下方
            let lastFrame = lastWindow.frame
            newFrame = NSRect(
                x: lastFrame.origin.x,
                y: lastFrame.origin.y - windowHeight - windowSpacing,
                width: windowWidth,
                height: windowHeight
            )
        } else {
            // 第一个窗口，使用默认位置
            newFrame = NSRect(
                x: 100,
                y: 500,
                width: windowWidth,
                height: windowHeight
            )
        }

        window.setFrame(newFrame, display: true)

        // 监听窗口关闭
        NotificationCenter.default.addObserver(
            forName: NSWindow.willCloseNotification,
            object: window,
            queue: .main
        ) { [weak self] _ in
            self?.removeFloatingWindow(noteId: note.id)
            onClose() // 关闭时回调
        }

        // 保存窗口引用和顺序
        floatingWindows[note.id] = window
        windowOrder.append(note.id)

        // 显示窗口
        window.makeKeyAndOrderFront(nil)
    }
    
    /// 隐藏悬浮便签窗口
    func hideFloatingNote(_ noteId: UUID) {
        floatingWindows[noteId]?.orderOut(nil)
    }
    
    /// 关闭悬浮便签窗口
    func closeFloatingNote(_ noteId: UUID) {
        floatingWindows[noteId]?.close()
        removeFloatingWindow(noteId: noteId)
    }
    
    /// 移除悬浮窗口引用
    private func removeFloatingWindow(noteId: UUID) {
        floatingWindows.removeValue(forKey: noteId)
        windowOrder.removeAll { $0 == noteId }
    }

    /// 获取悬浮窗口
    func getWindow(for noteId: UUID) -> NSWindow? {
        return floatingWindows[noteId]
    }
    
    /// 关闭所有悬浮窗口
    func closeAllFloatingNotes() {
        floatingWindows.values.forEach { $0.close() }
        floatingWindows.removeAll()
        windowOrder.removeAll()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

/// 悬浮便签视图
struct FloatingNoteView: View {
    @Binding var note: Note
    let onUpdate: (Note) -> Void
    let onClose: () -> Void

    var body: some View {
        NoteCard(
            note: $note,
            onDelete: {
                // 关闭窗口
                if let window = FloatingNoteService.shared.getWindow(for: note.id) {
                    window.close()
                }
                // 调用 onClose 回调
                onClose()
            },
            onToggleCollapse: {
                note.isCollapsed.toggle()
                onUpdate(note)
            },
            onTap: {},
            onToggleFloating: {
                // 关闭窗口
                if let window = FloatingNoteService.shared.getWindow(for: note.id) {
                    window.close()
                }
                // 调用 onClose 回调
                onClose()
            },
            isFloating: true,
            defaultEditing: false
        )
        .onChange(of: note) { _, newValue in
            onUpdate(newValue)
        }
    }
}