import SwiftUI

/// 便签卡片组件
struct NoteCard: View {
    @Binding var note: Note
    let onDelete: () -> Void
    let onToggleCollapse: () -> Void
    let onTap: () -> Void
    let onToggleFloating: () -> Void
    let isFloating: Bool
    
    @State private var isHovered = false
    @State private var isEditing: Bool

    init(note: Binding<Note>, 
         onDelete: @escaping () -> Void, 
         onToggleCollapse: @escaping () -> Void, 
         onTap: @escaping () -> Void,
         onToggleFloating: @escaping () -> Void = {},
         isFloating: Bool = false,
         defaultEditing: Bool = false) {
        self._note = note
        self.onDelete = onDelete
        self.onToggleCollapse = onToggleCollapse
        self.onTap = onTap
        self.onToggleFloating = onToggleFloating
        self.isFloating = isFloating
        self._isEditing = State(initialValue: defaultEditing)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 标题栏
            HStack {
                Image(systemName: "note.text")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)

                Text(note.displayTitle)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer()

                // 操作按钮(悬停时显示)
                if isHovered {
                    HStack(spacing: 6) {
                        // 悬浮置顶按钮 - 打开独立窗口
                        Button(action: {
                            onToggleFloating()
                        }) {
                            Image(systemName: isFloating ? "pin.fill" : "pin")
                                .font(.system(size: 14))
                                .foregroundColor(isFloating ? .white : .secondary)
                                .frame(width: 36, height: 36)
                                .background(isFloating ? Color.accentColor : Color(nsColor: .controlBackgroundColor))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .buttonStyle(.plain)

                        Button(action: { isEditing.toggle() }) {
                            Image(systemName: isEditing ? "checkmark" : "pencil")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                                .frame(width: isEditing ? 40 : 36, height: isEditing ? 40 : 36)
                                .background(Color(nsColor: .controlBackgroundColor))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .buttonStyle(.plain)

                        Button(action: onToggleCollapse) {
                            Image(systemName: note.isCollapsed ? "chevron.down" : "chevron.up")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                                .frame(width: 36, height: 36)
                                .background(Color(nsColor: .controlBackgroundColor))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .buttonStyle(.plain)

                        Button(action: onDelete) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                                .frame(width: 36, height: 36)
                                .background(Color(nsColor: .controlBackgroundColor))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .buttonStyle(.plain)
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isFloating ? Color.accentColor.opacity(0.1) : Color(nsColor: .controlBackgroundColor))

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
                        .contentShape(Rectangle())
                        .onTapGesture(count: 2) {
                            withAnimation {
                                isEditing = true
                            }
                        }
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
        .background(Color(nsColor: .windowBackgroundColor))
        .cornerRadius(8)
        .shadow(
            color: Color.black.opacity(isFloating ? 0.25 : (isHovered ? 0.15 : 0.1)),
            radius: isFloating ? 8 : (isHovered ? 4 : 2),
            x: 0,
            y: isFloating ? 4 : (isHovered ? 2 : 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    isFloating ? Color.accentColor : Color.accentColor.opacity(isHovered ? 0.3 : 0),
                    lineWidth: isFloating ? 2 : (isHovered ? 2 : 0)
                )
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