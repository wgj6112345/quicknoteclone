import Foundation

/// 便签数据仓库协议
protocol NoteRepository {
    /// 获取所有便签
    /// - Returns: 便签列表
    func fetchAll() async -> [Note]

    /// 根据 ID 获取便签
    /// - Parameter id: 便签 ID
    /// - Returns: 便签对象,不存在返回 nil
    func fetch(by id: UUID) async -> Note?

    /// 保存便签
    /// - Parameter note: 便签对象
    func save(_ note: Note) async throws

    /// 删除便签
    /// - Parameter id: 便签 ID
    func delete(_ id: UUID) async throws

    /// 获取应用设置
    /// - Returns: 应用设置
    func fetchSettings() async -> AppSettings

    /// 保存应用设置
    /// - Parameter settings: 应用设置
    func saveSettings(_ settings: AppSettings) async throws

    /// 导出数据
    /// - Returns: JSON 数据
    func exportData() async throws -> Data

    /// 导入数据
    /// - Parameter data: JSON 数据
    func importData(_ data: Data) async throws
}