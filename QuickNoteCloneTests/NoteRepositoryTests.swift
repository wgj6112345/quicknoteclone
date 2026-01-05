import XCTest
@testable import QuickNoteClone

final class NoteRepositoryTests: XCTestCase {
    var repository: UserDefaultsNoteRepository!
    var userDefaults: UserDefaults!

    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: "TestUserDefaults")
        userDefaults.removePersistentDomain(forName: "TestUserDefaults")
        repository = UserDefaultsNoteRepository(userDefaults: userDefaults)
    }

    override func tearDown() {
        repository = nil
        userDefaults.removePersistentDomain(forName: "TestUserDefaults")
        userDefaults = nil
        super.tearDown()
    }

    // MARK: - Fetch All Tests

    func testFetchAll_WhenEmpty_ReturnsEmptyArray() async {
        let notes = await repository.fetchAll()
        XCTAssertTrue(notes.isEmpty)
    }

    func testFetchAll_WhenHasNotes_ReturnsNotesSorted() async {
        let note1 = Note(title: "Note 1", content: "Content 1")
        let note2 = Note(title: "Note 2", content: "Content 2")

        try? await repository.save(note1)
        try? await repository.save(note2)

        let notes = await repository.fetchAll()
        XCTAssertEqual(notes.count, 2)
        XCTAssertEqual(notes[0].title, "Note 2") // 更新的在前面
    }

    // MARK: - Fetch By ID Tests

    func testFetch_WhenExists_ReturnsNote() async {
        let note = Note(title: "Test Note", content: "Test Content")
        try? await repository.save(note)

        let fetchedNote = await repository.fetch(by: note.id)
        XCTAssertNotNil(fetchedNote)
        XCTAssertEqual(fetchedNote?.title, "Test Note")
    }

    func testFetch_WhenNotExists_ReturnsNil() async {
        let fetchedNote = await repository.fetch(by: UUID())
        XCTAssertNil(fetchedNote)
    }

    // MARK: - Save Tests

    func testSave_WhenNewNote_CreatesNote() async throws {
        let note = Note(title: "New Note", content: "New Content")
        try await repository.save(note)

        let notes = await repository.fetchAll()
        XCTAssertEqual(notes.count, 1)
        XCTAssertEqual(notes[0].title, "New Note")
    }

    func testSave_WhenExistingNote_UpdatesNote() async throws {
        let note = Note(title: "Original Title", content: "Original Content")
        try await repository.save(note)

        var updatedNote = note
        updatedNote.title = "Updated Title"
        try await repository.save(updatedNote)

        let notes = await repository.fetchAll()
        XCTAssertEqual(notes.count, 1)
        XCTAssertEqual(notes[0].title, "Updated Title")
    }

    func testSave_WhenEmptyTitle_ThrowsError() async {
        let note = Note(title: "", content: "Content")
        await XCTAssertThrowsError(try await repository.save(note)) { error in
            XCTAssertEqual(error as? NoteError, .invalidTitle)
        }
    }

    func testSave_WhenTitleTooLong_ThrowsError() async {
        let longTitle = String(repeating: "a", count: 101)
        let note = Note(title: longTitle, content: "Content")
        await XCTAssertThrowsError(try await repository.save(note)) { error in
            XCTAssertEqual(error as? NoteError, .titleTooLong)
        }
    }

    func testSave_WhenContentTooLong_ThrowsError() async {
        let longContent = String(repeating: "a", count: 10001)
        let note = Note(title: "Title", content: longContent)
        await XCTAssertThrowsError(try await repository.save(note)) { error in
            XCTAssertEqual(error as? NoteError, .contentTooLong)
        }
    }

    // MARK: - Delete Tests

    func testDelete_WhenExists_RemovesNote() async throws {
        let note = Note(title: "To Delete", content: "Content")
        try await repository.save(note)

        try await repository.delete(note.id)

        let notes = await repository.fetchAll()
        XCTAssertTrue(notes.isEmpty)
    }

    func testDelete_WhenNotExists_Ignores() async throws {
        try await repository.delete(UUID())

        let notes = await repository.fetchAll()
        XCTAssertTrue(notes.isEmpty)
    }

    // MARK: - Settings Tests

    func testFetchSettings_WhenDefault_ReturnsDefaultSettings() async {
        let settings = await repository.fetchSettings()
        XCTAssertEqual(settings.windowPosition.x, 100)
        XCTAssertEqual(settings.windowPosition.y, 100)
        XCTAssertEqual(settings.windowSize.width, 400)
        XCTAssertEqual(settings.windowSize.height, 600)
    }

    func testSaveSettings_WhenNewSettings_SavesSettings() async throws {
        let newSettings = AppSettings(
            windowPosition: CGPoint(x: 200, y: 200),
            windowSize: CGSize(width: 500, height: 700),
            isDarkMode: true,
            isAlwaysOnTop: false,
            fontSize: 16,
            autoSaveInterval: 60
        )

        try await repository.saveSettings(newSettings)

        let fetchedSettings = await repository.fetchSettings()
        XCTAssertEqual(fetchedSettings.windowPosition.x, 200)
        XCTAssertEqual(fetchedSettings.windowPosition.y, 200)
        XCTAssertTrue(fetchedSettings.isDarkMode)
    }

    // MARK: - Import/Export Tests

    func testExportData_WhenHasNotes_ReturnsValidData() async throws {
        let note = Note(title: "Export Test", content: "Content")
        try await repository.save(note)

        let data = try await repository.exportData()
        XCTAssertFalse(data.isEmpty)
    }

    func testImportData_WhenValidData_ImportsNotes() async throws {
        let note1 = Note(title: "Imported 1", content: "Content 1")
        let note2 = Note(title: "Imported 2", content: "Content 2")
        let noteData = NoteData(notes: [note1, note2])

        let encoder = JSONEncoder()
        let data = try encoder.encode(noteData)

        try await repository.importData(data)

        let notes = await repository.fetchAll()
        XCTAssertEqual(notes.count, 2)
    }
}