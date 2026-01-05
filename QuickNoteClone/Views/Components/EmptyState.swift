import SwiftUI

/// 空状态组件
struct EmptyState: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "note.text")
                .font(.system(size: 64))
                .foregroundColor(.secondary)

            Text("还没有便签")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("点击上方按钮创建第一个便签")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}