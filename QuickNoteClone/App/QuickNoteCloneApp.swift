import SwiftUI

@main
struct QuickNoteCloneApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // 主窗口
        WindowGroup(content: {
            NoteListView()
        })
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)

        // 设置窗口
        Settings {
            SettingsView()
        }
    }
}
