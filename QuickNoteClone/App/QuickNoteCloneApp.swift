import SwiftUI

@main
struct QuickNoteCloneApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // 主窗口
        WindowGroup {
            NoteListView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)

        // 设置窗口
        Settings {
            EmptyView()
            // TODO: 将在应用设置阶段实现设置视图
            // SettingsView()
        }
    }
}