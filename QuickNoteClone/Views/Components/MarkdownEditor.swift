import SwiftUI

/// Markdown 编辑器组件
struct MarkdownEditor: View {
    @Binding var content: String
    @State private var isEditing = true
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            // 工具栏
            toolbar

            Divider()

            // 编辑器/预览
            if isEditing {
                editorView
            } else {
                previewView
            }
        }
        .background(Color(nsColor: .windowBackgroundColor))
    }

    // MARK: - Subviews

    private var toolbar: some View {
        HStack(spacing: 8) {
            // 模式切换按钮
            Button(action: { isEditing = true }) {
                Image(systemName: "pencil")
                    .font(.system(size: 14))
                    .foregroundColor(isEditing ? .accentColor : .secondary)
            }
            .buttonStyle(.borderless)
            .help("编辑模式 (⌘+E)")

            Button(action: { isEditing = false }) {
                Image(systemName: "doc.text")
                    .font(.system(size: 14))
                    .foregroundColor(!isEditing ? .accentColor : .secondary)
            }
            .buttonStyle(.borderless)
            .help("预览模式 (⌘+P)")

            Divider()
                .frame(height: 20)

            // 格式化按钮
            Button(action: insertBold) {
                Image(systemName: "bold")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.borderless)
            .help("粗体 (⌘+B)")

            Button(action: insertItalic) {
                Image(systemName: "italic")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.borderless)
            .help("斜体 (⌘+I)")

            Button(action: insertCode) {
                Image(systemName: "curlybraces")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.borderless)
            .help("代码 (⌘+⇧+K)")

            Button(action: insertLink) {
                Image(systemName: "link")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.borderless)
            .help("链接 (⌘+K)")

            Spacer()

            // 模式指示器
            Text(isEditing ? "编辑模式" : "预览模式")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(nsColor: .controlBackgroundColor))
    }

    private var editorView: some View {
        TextEditor(text: $content)
            .font(.system(size: 14, family: .monospaced))
            .padding(12)
            .focused($isFocused)
            .onTapGesture {
                isFocused = true
            }
    }

    private var previewView: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading, spacing: 12) {
                Text(renderMarkdown(content))
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(12)
        }
    }

    // MARK: - Private Methods

    private func insertBold() {
        insertMarkdown("**", "**")
    }

    private func insertItalic() {
        insertMarkdown("*", "*")
    }

    private func insertCode() {
        insertMarkdown("`", "`")
    }

    private func insertLink() {
        insertMarkdown("[", "] (url)")
    }

    private func insertMarkdown(_ prefix: String, _ suffix: String) {
        // TODO: 实现选中文本包裹功能
        content += prefix + "文本" + suffix
    }

    private func renderMarkdown(_ text: String) -> AttributedString {
        // 简化的 Markdown 渲染(生产环境应使用 MarkdownUI 库)
        var result = AttributedString(text)

        // 渲染标题
        if text.hasPrefix("# ") {
            result.font = .system(size: 24, weight: .bold)
        } else if text.hasPrefix("## ") {
            result.font = .system(size: 20, weight: .bold)
        } else if text.hasPrefix("### ") {
            result.font = .system(size: 16, weight: .semibold)
        }

        return result
    }
}

// MARK: - Preview

#Preview {
    MarkdownEditor(content: .constant("# 标题\n\n**粗体** *斜体* `代码`"))
        .frame(height: 200)
}
