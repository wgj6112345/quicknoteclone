import SwiftUI

/// 便签卡片组件
struct NoteCard: View {
    let note: Note
    let onDelete: () -> Void
    let onToggleCollapse: () -> Void
    let onTap: () -> Void

    @State private var isHovered = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 标题栏
            HStack {
                Image(systemName: "note.text")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)

                Text(note.title)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(.primary)

                Spacer()

                // 操作按钮(悬停时显示)
                if isHovered {
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
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(nsColor: .controlBackgroundColor))

            // 内容区域
            if !note.isCollapsed {
                Divider()

                Text(note.content)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color(nsColor: .windowBackgroundColor))
        .cornerRadius(8)
        .shadow(radius: isHovered ? 4 : 2)
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
            onTap()
        }
    }
}