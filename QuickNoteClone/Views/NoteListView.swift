import SwiftUI

/// 便签列表视图
struct NoteListView: View {
    @StateObject private var viewModel = NoteListViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            // 顶部工具栏
            toolbar

            Divider()

            // 便签列表
            if viewModel.isLoading {
                loadingView
            } else if viewModel.notes.isEmpty {
                emptyStateView
            } else {
                notesList
            }
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

    private var toolbar: some View {
        HStack {
            // 搜索栏
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)

                TextField("搜索便签...", text: $viewModel.searchText)
                    .textFieldStyle(.plain)
                    .font(.body)

                if !viewModel.searchText.isEmpty {
                    Button(action: { viewModel.searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.borderless)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(nsColor: .textBackgroundColor))
            )

            Spacer()

            // 新建便签按钮
            Button(action: viewModel.createNote) {
                Label("新建便签", systemImage: "plus")
                    .font(.system(size: 14, weight: .medium))
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
    }

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
