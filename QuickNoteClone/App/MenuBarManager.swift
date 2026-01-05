import AppKit
import SwiftUI

/// 菜单栏管理器
@MainActor
class MenuBarManager: ObservableObject {
    static let shared = MenuBarManager()

    private var statusItem: NSStatusItem?
    private var popover: NSPopover?
    private var mainWindow: NSWindow?

    // MARK: - Initialization

    private init() {
        setupMenuBar()
        setupPopover()
    }

    // MARK: - Setup Methods

    private func setupMenuBar() {
        // 创建菜单栏图标
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        if let button = statusItem?.button {
            // 设置图标
            button.image = NSImage(systemSymbolName: "note.text", accessibilityDescription: "QuickNote")
            button.image?.isTemplate = true

            // 设置点击事件
            button.action = #selector(togglePopover)
            button.target = self

            // 设置右键菜单
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }

        // 监听系统主题变化
        DistributedNotificationCenter.default().addObserver(
            self,
            selector: #selector(themeChanged),
            name: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
            object: nil
        )
    }

    private func setupPopover() {
        popover = NSPopover()
        popover?.contentSize = NSSize(width: 400, height: 600)
        popover?.behavior = .transient
        popover?.animates = true

        // TODO: 设置内容视图(将在窗口管理阶段实现)
        // popover?.contentViewController = NSHostingController(rootView: MainView())
    }

    // MARK: - Public Methods

    func setMainWindow(_ window: NSWindow?) {
        self.mainWindow = window
    }

    func showPopover() {
        guard let button = statusItem?.button else { return }

        // 显示 Popover
        popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)

        // 设置窗口置顶
        if let window = popover?.contentViewController?.view.window {
            window.level = .floating
        }

        // 激活应用
        NSApp.activate(ignoringOtherApps: true)
    }

    func hidePopover() {
        popover?.performClose(nil)
    }

    func createNewNote() {
        // TODO: 将在便签管理阶段实现
        print("创建新便签")
        showPopover()
    }

    func openSettings() {
        // TODO: 将在应用设置阶段实现
        print("打开设置")
    }

    func quitApp() {
        NSApplication.shared.terminate(nil)
    }

    // MARK: - Private Methods

    @objc private func togglePopover(_ sender: Any?) {
        guard let event = NSApp.currentEvent else { return }

        // 右键点击显示菜单
        if event.type == .rightMouseUp {
            showContextMenu()
            return
        }

        // 左键点击切换显示/隐藏
        if let popover = popover, popover.isShown {
            hidePopover()
        } else {
            showPopover()
        }
    }

    private func showContextMenu() {
        let menu = NSMenu()

        // 新建便签
        let newItem = NSMenuItem(
            title: "新建便签",
            action: #selector(createNewNote),
            keyEquivalent: "n"
        )
        newItem.target = self
        menu.addItem(newItem)

        menu.addItem(NSMenuItem.separator())

        // 搜索便签
        let searchItem = NSMenuItem(
            title: "搜索便签",
            action: #selector(searchNotes),
            keyEquivalent: "f"
        )
        searchItem.target = self
        menu.addItem(searchItem)

        menu.addItem(NSMenuItem.separator())

        // 设置
        let settingsItem = NSMenuItem(
            title: "设置...",
            action: #selector(openSettings),
            keyEquivalent: ","
        )
        settingsItem.target = self
        menu.addItem(settingsItem)

        menu.addItem(NSMenuItem.separator())

        // 退出应用
        let quitItem = NSMenuItem(
            title: "退出应用",
            action: #selector(quitApp),
            keyEquivalent: "q"
        )
        quitItem.target = self
        menu.addItem(quitItem)

        // 显示菜单
        statusItem?.button?.performClick(nil)
        statusItem?.menu = menu
        statusItem?.button?.menu = nil
    }

    @objc private func searchNotes() {
        // TODO: 将在便签管理阶段实现
        print("搜索便签")
        showPopover()
    }

    @objc private func themeChanged() {
        // 系统主题变化时更新图标颜色
        updateIconColor()
    }

    private func updateIconColor() {
        guard let button = statusItem?.button else { return }

        // 根据系统主题设置图标颜色
        let isDarkMode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
        button.image?.isTemplate = true

        // TODO: 根据是否有便签数据更改图标颜色(将在便签管理阶段实现)
    }
}