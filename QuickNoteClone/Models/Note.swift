import Foundation

/// 便签颜色枚举
enum NoteColor: String, CaseIterable, Codable {
    case yellow = "yellow"
    case blue = "blue"
    case green = "green"
    case pink = "pink"
    case purple = "purple"

    var color: String {
        switch self {
        case .yellow: return "yellow"
        case .blue: return "blue"
        case .green: return "green"
        case .pink: return "pink"
        case .purple: return "purple"
        }
    }
}

/// 便签实体
struct Note: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var updatedAt: Date
    var isCollapsed: Bool
    var isFloating: Bool
    var color: NoteColor?

    init(
        id: UUID = UUID(),
        title: String = "新便签",
        content: String = "",
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        isCollapsed: Bool = false,
        isFloating: Bool = false,
        color: NoteColor? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isCollapsed = isCollapsed
        self.isFloating = isFloating
        self.color = color
    }

    /// 验证便签数据
    func validate() throws {
        if title.isEmpty {
            throw NoteError.invalidTitle
        }

        if title.count > 100 {
            throw NoteError.titleTooLong
        }

        if content.count > 10000 {
            throw NoteError.contentTooLong
        }
    }
    
    /// 显示标题 (自动提取 content 前 15 个字符)
    var displayTitle: String {
        if content.isEmpty {
            return "新便签"
        }
        
        if content.count <= 15 {
            return content
        }
        
        let index = content.index(content.startIndex, offsetBy: 15)
        return String(content[..<index]) + "..."
    }
}

/// 便签错误
enum NoteError: LocalizedError {
    case invalidTitle
    case titleTooLong
    case contentTooLong
    case saveFailed
    case notFound

    var errorDescription: String? {
        switch self {
        case .invalidTitle:
            return "便签标题不能为空"
        case .titleTooLong:
            return "便签标题过长(最大100字符)"
        case .contentTooLong:
            return "便签内容过长(最大10000字符)"
        case .saveFailed:
            return "保存失败"
        case .notFound:
            return "便签不存在"
        }
    }
}