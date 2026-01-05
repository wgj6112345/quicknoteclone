import Foundation

/// 便签服务
actor NoteService {
    static let shared = NoteService()

    private let repository: NoteRepository

    init(repository: NoteRepository = UserDefaultsNoteRepository()) {
        self.repository = repository
    }

    // MARK: - Note Operations

    /// 获取所有便签
    /// - Returns: 按更新时间降序排列的便签列表
    func getAllNotes() async -> [Note] {
        return await repository.fetchAll()
    }

    /// 根据 ID 获取便签
    /// - Parameter id: 便签 ID
    /// - Returns: 便签对象,不存在返回 nil
    func getNote(by id: UUID) async -> Note? {
        return await repository.fetch(by: id)
    }

    /// 创建便签
    /// - Parameter note: 便签对象
    /// - Throws: 便签验证失败或保存失败时抛出错误
    func createNote(_ note: Note) async throws {
        try await repository.save(note)
    }

    /// 更新便签
    /// - Parameter note: 便签对象
    /// - Throws: 便签验证失败或保存失败时抛出错误
    func updateNote(_ note: Note) async throws {
        try await repository.save(note)
    }

    /// 删除便签
    /// - Parameter id: 便签 ID
    /// - Throws: 删除失败时抛出错误
    func deleteNote(_ id: UUID) async throws {
        try await repository.delete(id)
    }

    /// 搜索便签
    /// - Parameter query: 搜索关键词
    /// - Returns: 匹配的便签列表
    func searchNotes(query: String) async -> [Note] {
        let notes = await repository.fetchAll()
        guard !query.isEmpty else { return notes }

        return notes.filter { note in
            note.title.localizedCaseInsensitiveContains(query) ||
            note.content.localizedCaseInsensitiveContains(query)
        }
    }

    // MARK: - Settings Operations

    /// 获取应用设置
    /// - Returns: 应用设置
    func getSettings() async -> AppSettings {
        return await repository.fetchSettings()
    }

    /// 保存应用设置
    /// - Parameter settings: 应用设置
    /// - Throws: 保存失败时抛出错误
    func saveSettings(_ settings: AppSettings) async throws {
        try await repository.saveSettings(settings)
    }

    // MARK: - Import/Export

    /// 导出数据
    /// - Returns: JSON 数据
    /// - Throws: 导出失败时抛出错误
    func exportData() async throws -> Data {
        return try await repository.exportData()
    }

    /// 导入数据
    /// - Parameter data: JSON 数据
    /// - Throws: 导入失败时抛出错误
    func importData(_ data: Data) async throws {
        try await repository.importData(data)
    }
}