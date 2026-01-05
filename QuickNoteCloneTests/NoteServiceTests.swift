import XCTest
@testable import QuickNoteClone

final class NoteServiceTests: XCTestCase {
    var service: NoteService!
    var mockRepository: MockNoteRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockNoteRepository()
        service = NoteService(repository: mockRepository)
    }

    override func tearDown() {
        service = nil
        mockRepository = nil
        super.tearDown()
    }

    // MARK: - Get All Notes Tests

    func testGetAllNotes_ReturnsNotes() async {
        let notes = [
            Note(title: "Note 1", content: "Content 1"),
            Note(title: "Note 2", content: "Content 2")
        ]
        mockRepository.notes = notes

        let result = await service.getAllNotes()
        XCTAssertEqual(result.count, 2)
    }

    // MARK: - Get Note Tests

    func testGetNote_WhenExists_ReturnsNote() async {
        let note = Note(title: "Test", content: "Content")
        mockRepository.notes = [note]

        let result = await service.getNote(by: note.id)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title, "Test")
    }

    func testGetNote_WhenNotExists_ReturnsNil() async {
        let result = await service.getNote(by: UUID())
        XCTAssertNil(result)
    }

    // MARK: - Create Note Tests

    func testCreateNote_SavesNote() async throws {
        let note = Note(title: "New Note", content: "Content")

        try await service.createNote(note)

        XCTAssertTrue(mockRepository.saveCalled)
        XCTAssertEqual(mockRepository.lastSavedNote?.title, "New Note")
    }

    // MARK: - Update Note Tests

    func testUpdateNote_UpdatesNote() async throws {
        let note = Note(title: "Original", content: "Content")
        var updatedNote = note
        updatedNote.title = "Updated"

        try await service.updateNote(updatedNote)

        XCTAssertTrue(mockRepository.saveCalled)
        XCTAssertEqual(mockRepository.lastSavedNote?.title, "Updated")
    }

    // MARK: - Delete Note Tests

    func testDeleteNote_DeletesNote() async throws {
        let note = Note(title: "To Delete", content: "Content")

        try await service.deleteNote(note.id)

        XCTAssertTrue(mockRepository.deleteCalled)
        XCTAssertEqual(mockRepository.lastDeletedId, note.id)
    }

    // MARK: - Search Notes Tests

    func testSearchNotes_WhenQueryMatches_ReturnsNotes() async {
        let notes = [
            Note(title: "Meeting Notes", content: "Project discussion"),
            Note(title: "Shopping List", content: "Groceries")
        ]
        mockRepository.notes = notes

        let results = await service.searchNotes(query: "meeting")
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results[0].title, "Meeting Notes")
    }

    func testSearchNotes_WhenQueryEmpty_ReturnsAllNotes() async {
        let notes = [
            Note(title: "Note 1", content: "Content 1"),
            Note(title: "Note 2", content: "Content 2")
        ]
        mockRepository.notes = notes

        let results = await service.searchNotes(query: "")
        XCTAssertEqual(results.count, 2)
    }

    // MARK: - Settings Tests

    func testGetSettings_ReturnsSettings() async {
        let settings = AppSettings(isDarkMode: true)
        mockRepository.settings = settings

        let result = await service.getSettings()
        XCTAssertTrue(result.isDarkMode)
    }

    func testSaveSettings_SavesSettings() async throws {
        let settings = AppSettings(isDarkMode: true)

        try await service.saveSettings(settings)

        XCTAssertTrue(mockRepository.saveSettingsCalled)
    }

    // MARK: - Import/Export Tests

    func testExportData_ExportData() async throws {
        let data = Data([1, 2, 3])
        mockRepository.exportDataResult = data

        let result = try await service.exportData()
        XCTAssertEqual(result, data)
    }

    func testImportData_ImportData() async throws {
        let data = Data([1, 2, 3])

        try await service.importData(data)

        XCTAssertTrue(mockRepository.importDataCalled)
    }
}

// MARK: - Mock Repository

class MockNoteRepository: NoteRepository {
    var notes: [Note] = []
    var settings: AppSettings = AppSettings()
    var saveCalled = false
    var deleteCalled = false
    var saveSettingsCalled = false
    var importDataCalled = false
    var exportDataResult = Data()
    var lastSavedNote: Note?
    var lastDeletedId: UUID?

    func fetchAll() async -> [Note] {
        return notes.sorted { $0.updatedAt > $1.updatedAt }
    }

    func fetch(by id: UUID) async -> Note? {
        return notes.first { $0.id == id }
    }

    func save(_ note: Note) async throws {
        saveCalled = true
        lastSavedNote = note

        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
        } else {
            notes.append(note)
        }
    }

    func delete(_ id: UUID) async throws {
        deleteCalled = true
        lastDeletedId = id
        notes.removeAll { $0.id == id }
    }

    func fetchSettings() async -> AppSettings {
        return settings
    }

    func saveSettings(_ settings: AppSettings) async throws {
        saveSettingsCalled = true
        self.settings = settings
    }

    func exportData() async throws -> Data {
        return exportDataResult
    }

    func importData(_ data: Data) async throws {
        importDataCalled = true
    }
}