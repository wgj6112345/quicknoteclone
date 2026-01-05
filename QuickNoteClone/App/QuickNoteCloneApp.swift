import SwiftUI

@main
struct QuickNoteCloneApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // 不使用 WindowGroup,因为 AppDelegate 已经创建了窗口
        // 设置窗口
        Settings {
            SettingsView()
        }
    }
}
