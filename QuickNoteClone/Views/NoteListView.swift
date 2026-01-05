import SwiftUI

/// 便签列表视图
struct NoteListView: View {
    @StateObject private var viewModel = NoteListViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // 便签列表
            if viewModel.isLoading {
                loadingView
            } else if viewModel.notes.isEmpty {
                emptyStateView
            } else {
                notesList
            }

            // 右下角新建按钮
            Button(action: viewModel.createNote) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            .buttonStyle(.plain)
            .padding(16)
        }
        .frame(minWidth: Constants.Window.minWidth, minHeight: Constants.Window.minHeight)
        .alert("删除便签", isPresented: $viewModel.showingDeleteAlert) {
            Button("取消", role: .cancel) {
                viewModel.cancelDeleteNote()
            }
            Button("删除", role: .destructive) {
                viewModel.confirmDeleteNote()
            }
        } message: {
            if let note = viewModel.noteToDelete {
                Text("确定要删除便签 \"\(note.title)\"吗?")
            }
        }
    }

    // MARK: - Subviews

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)

            Text("加载中...")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyStateView: some View {
        EmptyState()
    }

    private var notesList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.notes) { note in
                    NoteCard(
                        note: Binding(
                            get: {
                                // 通过 ID 查找最新的 note 对象
                                if let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) {
                                    return viewModel.notes[index]
                                }
                                return note
                            },
                            set: { newValue in
                                viewModel.updateNote(newValue)
                            }
                        ),
                        onDelete: { viewModel.deleteNote(note) },
                        onToggleCollapse: { viewModel.toggleCollapse(note) },
                        onTap: { viewModel.selectNote(note) },
                        onToggleFloating: { viewModel.toggleFloating(note) },
                        isFloating: note.isFloating,
                        defaultEditing: viewModel.isNewNote(note)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                viewModel.selectedNoteId == note.id ? Color.accentColor : Color.clear,
                                lineWidth: 2
                            )
                    )
                    .onAppear {
                        // 便签出现后清除新便签标记
                        if viewModel.isNewNote(note) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                viewModel.clearNewNoteMark()
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    NoteListView()
        .frame(width: 400, height: 600)
}
