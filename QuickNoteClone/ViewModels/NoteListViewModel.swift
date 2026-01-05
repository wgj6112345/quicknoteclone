import SwiftUI
import Combine

/// 便签列表视图模型
@MainActor
class NoteListViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var selectedNoteId: UUID?
    @Published var showingDeleteAlert: Bool = false
    @Published var noteToDelete: Note?

    private let noteService: NoteService
    private var searchCancellable: AnyCancellable?
    private var saveCancellables = [UUID: AnyCancellable]()

    init(noteService: NoteService = .shared) {
        self.noteService = noteService
        loadNotes()
        setupSearch()
    }

    // MARK: - Public Methods

    /// 加载便签列表
    func loadNotes() {
        isLoading = true

        Task {
            notes = await noteService.getAllNotes()
            isLoading = false
        }
    }

    /// 创建新便签
    func createNote() {
        let newNote = Note()

        Task {
            do {
                try await noteService.createNote(newNote)
                await MainActor.run {
                    notes.insert(newNote, at: 0)
                    selectedNoteId = newNote.id
                }
            } catch {
                print("创建便签失败: \(error.localizedDescription)")
            }
        }
    }

    /// 更新便签
    func updateNote(_ note: Note) {
        Task {
            do {
                try await noteService.updateNote(note)
                await MainActor.run {
                    if let index = notes.firstIndex(where: { $0.id == note.id }) {
                        notes[index] = note
                    }
                }
            } catch {
                print("更新便签失败: \(error.localizedDescription)")
            }
        }
    }

    /// 删除便签
    func deleteNote(_ note: Note) {
        noteToDelete = note
        showingDeleteAlert = true
    }

    /// 确认删除便签
    func confirmDeleteNote() {
        guard let note = noteToDelete else { return }

        Task {
            do {
                try await noteService.deleteNote(note.id)
                await MainActor.run {
                    notes.removeAll { $0.id == note.id }
                    if selectedNoteId == note.id {
                        selectedNoteId = nil
                    }
                    noteToDelete = nil
                    showingDeleteAlert = false
                }
            } catch {
                print("删除便签失败: \(error.localizedDescription)")
            }
        }
    }

    /// 取消删除便签
    func cancelDeleteNote() {
        noteToDelete = nil
        showingDeleteAlert = false
    }

    /// 选择便签
    func selectNote(_ note: Note) {
        selectedNoteId = note.id
    }

    /// 切换便签折叠状态
    func toggleCollapse(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isCollapsed.toggle()
            updateNote(notes[index])
        }
    }

    // MARK: - Private Methods

    private func setupSearch() {
        searchCancellable = $searchText
            .debounce(for: .milliseconds(Int(Constants.Performance.maxSearchDelay * 1000)), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.performSearch()
            }
    }

    private func performSearch() {
        Task {
            if searchText.isEmpty {
                notes = await noteService.getAllNotes()
            } else {
                notes = await noteService.searchNotes(query: searchText)
            }
        }
    }
}