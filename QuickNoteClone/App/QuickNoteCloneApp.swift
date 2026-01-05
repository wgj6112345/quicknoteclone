import SwiftUI

@main
struct QuickNoteCloneApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // 主窗口(将在窗口管理阶段实现)
        // WindowGroup {
        //     MainView()
        // }

        // 设置窗口
        Settings {
            EmptyView()
        }
    }
}