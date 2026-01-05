import SwiftUI
import Combine

/// 便签列表视图模型
@MainActor
class NoteListViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var isLoading: Bool = false
    @Published var selectedNoteId: UUID?
    @Published var showingDeleteAlert: Bool = false
    @Published var noteToDelete: Note?
    @Published var newNoteId: UUID?

    private let noteService: NoteService
    private var saveCancellables = [UUID: AnyCancellable]()

    init(noteService: NoteService = .shared) {
        self.noteService = noteService
        loadNotes()
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
                    newNoteId = newNote.id  // 标记为新创建的便签
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

    /// 切换便签悬浮状态
    func toggleFloating(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isFloating.toggle()
            updateNote(notes[index])
        }
    }

    /// 检查是否是新创建的便签
    func isNewNote(_ note: Note) -> Bool {
        return note.id == newNoteId
    }

    /// 清除新便签标记
    func clearNewNoteMark() {
        newNoteId = nil
    }

    // MARK: - Private Methods
}
