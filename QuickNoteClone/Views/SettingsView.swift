//
//  SettingsView.swift
//  QuickNoteClone
//
//  Created by Wang Gaojie on 1/5/26.
//


import SwiftUI

/// 设置视图
struct SettingsView: View {
    @StateObject private var viewModel = AppViewModel.shared
    @State private var showingResetAlert = false

    var body: some View {
        VStack(spacing: 0) {
            // 标题栏
            HStack {
                Text("设置")
                    .font(.title2)
                    .fontWeight(.semibold)

                Spacer()

                Button("关闭") {
                    NSApp.keyWindow?.close()
                }
                .buttonStyle(.borderless)
            }
            .padding()

            Divider()

            // 设置内容
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // 外观设置
                    appearanceSection

                    // 行为设置
                    behaviorSection

                    // 快捷键说明
                    shortcutsSection

                    // 重置设置
                    resetSection
                }
                .padding()
            }
        }
        .frame(width: 500, height: 600)
        .alert("重置设置", isPresented: $showingResetAlert) {
            Button("取消", role: .cancel) { }
            Button("重置", role: .destructive) {
                Task {
                    await viewModel.resetSettings()
                }
            }
        } message: {
            Text("确定要将所有设置恢复为默认值吗?")
        }
    }

    // MARK: - Subviews

    private var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("外观")
                .font(.headline)
                .foregroundColor(.primary)

            Toggle("深色模式", isOn: $viewModel.isDarkMode)
                .help("切换深色/浅色主题 (⌘+⇧+D)")

            VStack(alignment: .leading, spacing: 4) {
                Text("字体大小: \(Int(viewModel.appSettings.fontSize))px")
                    .font(.body)
                    .foregroundColor(.primary)

                Slider(
                    value: $viewModel.appSettings.fontSize,
                    in: Constants.Settings.minFontSize...Constants.Settings.maxFontSize,
                    step: 1
                )
                .help("调整字体大小 (\(Int(Constants.Settings.minFontSize))-\(Int(Constants.Settings.maxFontSize))px)")
            }
        }
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
    }

    private var behaviorSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("行为")
                .font(.headline)
                .foregroundColor(.primary)

            Toggle("窗口置顶", isOn: $viewModel.isAlwaysOnTop)
                .help("窗口始终位于其他应用窗口之上 (⌘+⇧+F)")

            VStack(alignment: .leading, spacing: 4) {
                Text("自动保存间隔: \(Int(viewModel.appSettings.autoSaveInterval))秒")
                    .font(.body)
                    .foregroundColor(.primary)

                Slider(
                    value: $viewModel.appSettings.autoSaveInterval,
                    in: Constants.Settings.minAutoSaveInterval...Constants.Settings.maxAutoSaveInterval,
                    step: 10
                )
                .help("自动保存便签的时间间隔 (\(Int(Constants.Settings.minAutoSaveInterval))-\(Int(Constants.Settings.maxAutoSaveInterval))秒)")
            }
        }
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
    }

    private var shortcutsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("快捷键")
                .font(.headline)
                .foregroundColor(.primary)

            VStack(alignment: .leading, spacing: 8) {
                ShortcutRow(title: "新建便签", shortcut: "⌘ + N")
                ShortcutRow(title: "关闭便签", shortcut: "⌘ + W")
                ShortcutRow(title: "打开设置", shortcut: "⌘ + ,")
                ShortcutRow(title: "编辑/预览", shortcut: "⌘ + /")
                ShortcutRow(title: "切换置顶", shortcut: "⌘ + ⇧ + F")
                ShortcutRow(title: "深色模式", shortcut: "⌘ + ⇧ + D")
            }
        }
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
    }

    private var resetSection: some View {
        Button(action: { showingResetAlert = true }) {
            Label("重置所有设置", systemImage: "arrow.counterclockwise")
                .font(.body)
                .foregroundColor(.red)
        }
        .buttonStyle(.borderless)
    }
}

/// 快捷键行组件
struct ShortcutRow: View {
    let title: String
    let shortcut: String

    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(.primary)

            Spacer()

            Text(shortcut)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(nsColor: .textBackgroundColor))
                .cornerRadius(4)
        }
    }
}

// MARK: - Preview

#Preview {
    SettingsView()
}