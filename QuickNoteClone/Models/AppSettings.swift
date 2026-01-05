import Foundation
import CoreGraphics

/// 应用设置
struct AppSettings: Codable {
    var windowPosition: CGPoint
    var windowSize: CGSize
    var isDarkMode: Bool
    var isAlwaysOnTop: Bool
    var fontSize: Double
    var autoSaveInterval: TimeInterval

    init(
        windowPosition: CGPoint = CGPoint(x: 100, y: 100),
        windowSize: CGSize = CGSize(width: 400, height: 600),
        isDarkMode: Bool = false,
        isAlwaysOnTop: Bool = true,
        fontSize: Double = 14,
        autoSaveInterval: TimeInterval = 30
    ) {
        self.windowPosition = windowPosition
        self.windowSize = windowSize
        self.isDarkMode = isDarkMode
        self.isAlwaysOnTop = isAlwaysOnTop
        self.fontSize = fontSize
        self.autoSaveInterval = autoSaveInterval
    }
}

/// 便签数据容器
struct NoteData: Codable {
    var notes: [Note]
    var appSettings: AppSettings

    init(notes: [Note] = [], appSettings: AppSettings = AppSettings()) {
        self.notes = notes
        self.appSettings = appSettings
    }
}