import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarManager: MenuBarManager?
    var windowService: WindowService?
    var mainWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // 初始化窗口服务
        windowService = WindowService.shared

        // 创建主窗口
        mainWindow = windowService?.createMainWindow()

        // 设置窗口内容
        if let window = mainWindow {
            let contentView = NoteListView()
            window.contentViewController = NSHostingController(rootView: contentView)
            
            // 显示窗口
            window.makeKeyAndOrderFront(nil)
        }

        // 初始化菜单栏管理器
        menuBarManager = MenuBarManager.shared
        menuBarManager?.setMainWindow(mainWindow)

        // 在 Dock 栏显示应用图标
        NSApp.setActivationPolicy(.regular)

        print("QuickNote Clone 启动完成")
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        // 不退出应用,继续在菜单栏运行
        return false
    }

    func applicationWillTerminate(_ notification: Notification) {
        // 应用终止前的清理工作
        print("QuickNote Clone 即将退出")
    }
}
