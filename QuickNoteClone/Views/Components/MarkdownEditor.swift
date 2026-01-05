import SwiftUI

/// Markdown 编辑器组件
struct MarkdownEditor: View {
    @Binding var content: String
    @State private var isEditing: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            if isEditing {
                editorView
            } else {
                previewView
            }
        }
        .background(Color(nsColor: .windowBackgroundColor))
    }

    private var editorView: some View {
        TextEditor(text: $content)
            .font(.system(.body, design: .monospaced))
            .padding(8)
            .scrollContentBackground(.hidden)
            .background(Color(nsColor: .textBackgroundColor))
    }

    private var previewView: some View {
        ScrollView {
            Text(content)
                .font(.body)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}