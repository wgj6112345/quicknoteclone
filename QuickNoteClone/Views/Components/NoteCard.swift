import SwiftUI

/// 便签卡片组件
struct NoteCard: View {
    @Binding var note: Note
    let onDelete: () -> Void
    let onToggleCollapse: () -> Void
    let onTap: () -> Void

    @State private var isHovered = false
    @State private var isEditing = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 标题栏
            HStack {
                Image(systemName: "note.text")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)

                TextField("标题", text: $note.title)
                    .textFieldStyle(.plain)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .disabled(!isEditing)

                Spacer()

                // 操作按钮(悬停时显示)
                if isHovered {
                    HStack(spacing: 4) {
                        Button(action: { isEditing.toggle() }) {
                            Image(systemName: isEditing ? "checkmark" : "pencil")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                        .buttonStyle(.borderless)
                        .scaleEffect(isEditing ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isEditing)

                        Button(action: onToggleCollapse) {
                            Image(systemName: note.isCollapsed ? "chevron.down" : "chevron.up")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                        .buttonStyle(.borderless)

                        Button(action: onDelete) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                        .buttonStyle(.borderless)
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(nsColor: .controlBackgroundColor))

            // 内容区域
            if !note.isCollapsed {
                Divider()

                if isEditing {
                    MarkdownEditor(content: $note.content)
                        .frame(minHeight: 100)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                } else {
                    Text(note.content)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
        .background(Color(nsColor: .windowBackgroundColor))
        .cornerRadius(8)
        .shadow(
            color: Color.black.opacity(isHovered ? 0.15 : 0.1),
            radius: isHovered ? 4 : 2,
            x: 0,
            y: isHovered ? 2 : 1
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.accentColor.opacity(isHovered ? 0.3 : 0), lineWidth: isHovered ? 2 : 0)
        )
        .onHover { hovering in
            withAnimation(.easeOut(duration: 0.1)) {
                isHovered = hovering
            }
        }
        .onTapGesture {
            if !isEditing {
                onTap()
            }
        }
        .animation(.easeInOut(duration: 0.2), value: note.isCollapsed)
    }
}