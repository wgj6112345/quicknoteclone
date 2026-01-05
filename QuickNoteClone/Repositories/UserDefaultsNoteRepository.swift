import Foundation

/// UserDefaults 便签仓库实现
actor UserDefaultsNoteRepository: NoteRepository {
    private enum Keys {
        static let noteData = "noteData"
    }

    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults

        // 配置编码器
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
        self.encoder.outputFormatting = .prettyPrinted

        // 配置解码器
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }

    // MARK: - Private Methods

    private func loadNoteData() async -> NoteData {
        guard let data = userDefaults.data(forKey: Keys.noteData),
              let noteData = try? decoder.decode(NoteData.self, from: data) else {
            return NoteData()
        }
        return noteData
    }

    private func saveNoteData(_ noteData: NoteData) async throws {
        let data = try encoder.encode(noteData)
        userDefaults.set(data, forKey: Keys.noteData)
    }

    // MARK: - Public Methods

    func fetchAll() async -> [Note] {
        let noteData = await loadNoteData()
        return noteData.notes.sorted { $0.updatedAt > $1.updatedAt }
    }

    func fetch(by id: UUID) async -> Note? {
        let notes = await fetchAll()
        return notes.first { $0.id == id }
    }

    func save(_ note: Note) async throws {
        var noteData = await loadNoteData()

        // 验证便签数据
        try note.validate()

        // 检查便签数量限制
        if noteData.notes.count >= 50 && !noteData.notes.contains(where: { $0.id == note.id }) {
            throw NoteError.saveFailed
        }

        // 更新或添加便签
        if let index = noteData.notes.firstIndex(where: { $0.id == note.id }) {
            var updatedNote = note
            updatedNote.updatedAt = Date()
            noteData.notes[index] = updatedNote
        } else {
            var newNote = note
            newNote.createdAt = Date()
            newNote.updatedAt = Date()
            noteData.notes.append(newNote)
        }

        try await saveNoteData(noteData)
    }

    func delete(_ id: UUID) async throws {
        var noteData = await loadNoteData()
        noteData.notes.removeAll { $0.id == id }
        try await saveNoteData(noteData)
    }

    func fetchSettings() async -> AppSettings {
        let noteData = await loadNoteData()
        return noteData.appSettings
    }

    func saveSettings(_ settings: AppSettings) async throws {
        var noteData = await loadNoteData()
        noteData.appSettings = settings
        try await saveNoteData(noteData)
    }

    func exportData() async throws -> Data {
        let noteData = await loadNoteData()
        return try encoder.encode(noteData)
    }

    func importData(_ data: Data) async throws {
        let importedData = try decoder.decode(NoteData.self, from: data)
        var currentData = await loadNoteData()

        // 合并数据
        let existingIds = Set(currentData.notes.map { $0.id })
        let newNotes = importedData.notes.filter { !existingIds.contains($0.id) }
        currentData.notes.append(contentsOf: newNotes)

        try await saveNoteData(currentData)
    }
}