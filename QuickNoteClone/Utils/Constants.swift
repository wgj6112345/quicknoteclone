import Foundation

/// 应用常量
enum Constants {
    /// 便签相关
    enum Note {
        static let maxCount = 50
        static let maxTitleLength = 100
        static let maxContentLength = 10000
        static let defaultTitle = "新便签"
    }

    /// 应用设置相关
    enum Settings {
        static let minFontSize: Double = 10
        static let maxFontSize: Double = 24
        static let defaultFontSize: Double = 14
        static let minAutoSaveInterval: TimeInterval = 10
        static let maxAutoSaveInterval: TimeInterval = 300
        static let defaultAutoSaveInterval: TimeInterval = 30
    }

    /// 窗口相关
    enum Window {
        static let minWidth: CGFloat = 300
        static let minHeight: CGFloat = 400
        static let maxWidth: CGFloat = 800
        static let maxHeight: CGFloat = 1200
        static let defaultWidth: CGFloat = 400
        static let defaultHeight: CGFloat = 600
        static let defaultPosition = CGPoint(x: 100, y: 100)
    }

    /// 性能相关
    enum Performance {
        static let autoSaveDebounceDelay: TimeInterval = 0.3
        static let maxRenderDelay: TimeInterval = 0.2
        static let maxSearchDelay: TimeInterval = 0.2
    }
}