# QuickNote Clone

一个简洁优雅的 macOS 便签应用，支持悬浮便签和 Markdown 编辑。

![QuickNote](https://img.shields.io/badge/macOS-14.0+-blue)
![Swift](https://img.shields.io/badge/Swift-5.9+-orange)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ 功能特性

- 📝 **便签管理** - 快速创建、编辑、删除便签
- ✍️ **Markdown 编辑** - 支持 Markdown 语法编辑
- 📌 **悬浮便签** - 便签可以悬浮在屏幕任意位置
- 🎯 **自动排列** - 新悬浮便签自动排列在已有便签下方
- 📋 **复制标题** - 自动提取便签内容前 15 个字符作为标题
- 🎨 **简洁界面** - 现代化的 UI 设计，操作直观
- 🖥️ **菜单栏集成** - 在菜单栏快速访问应用
- 💾 **本地存储** - 数据保存在本地，隐私安全

## 🛠 技术栈

- **语言**: Swift 5.9+
- **框架**: SwiftUI
- **架构**: MVVM + Clean Architecture
- **平台**: macOS 14.0+
- **依赖**: 无第三方依赖

## 📦 安装

### 前置要求

- macOS 14.0 或更高版本
- Xcode 15.0 或更高版本

### 克隆项目

```bash
git clone https://github.com/wgj6112345/quicknoteclone.git
cd quicknoteclone
```

### 运行项目

1. 使用 Xcode 打开项目：
   ```bash
   open QuickNote.xcodeproj
   ```

2. 在 Xcode 中选择目标设备（My Mac）

3. 点击运行按钮（⌘ + R）或选择 `Product` → `Run`

## 🎯 使用方法

### 创建便签

- 点击右下角的 `+` 按钮创建新便签
- 新便签自动进入编辑模式

### 编辑便签

- 双击便签内容区域进入编辑模式
- 支持 Markdown 语法
- 点击保存按钮（✓）保存更改

### 悬浮便签

- 点击便签右上角的置顶按钮（📌）
- 便签会以独立窗口形式悬浮在屏幕上
- 悬浮便签自动排列，新便签放在已有便签下方
- 点击取消置顶按钮（📌）关闭悬浮窗口

### 管理便签

- **折叠/展开**: 点击折叠按钮（↑/↓）
- **删除便签**: 点击删除按钮（×）
- **查看标题**: 自动显示便签内容前 15 个字符

## 📸 截图

*待添加截图*

## 🏗 项目结构

```
QuickNoteClone/
├── App/                    # 应用入口
│   ├── AppDelegate.swift
│   ├── MenuBarManager.swift
│   └── QuickNoteCloneApp.swift
├── Models/                 # 数据模型
│   ├── AppSettings.swift
│   └── Note.swift
├── Repositories/           # 数据仓库
│   ├── NoteRepository.swift
│   └── UserDefaultsNoteRepository.swift
├── Services/               # 业务服务
│   ├── FloatingNoteService.swift
│   ├── NoteService.swift
│   └── WindowService.swift
├── ViewModels/             # 视图模型
│   ├── AppViewModel.swift
│   └── NoteListViewModel.swift
├── Views/                  # 视图
│   ├── NoteListView.swift
│   ├── SettingsView.swift
│   └── Components/
│       ├── EmptyState.swift
│       ├── MarkdownEditor.swift
│       └── NoteCard.swift
├── Utils/                  # 工具类
│   └── Constants.swift
└── Resources/              # 资源文件
    ├── Assets.xcassets/
    └── Info.plist
```

## 🤝 贡献指南

欢迎贡献代码！请遵循以下步骤：

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

## 📝 开发计划

- [ ] 添加便签搜索功能
- [ ] 支持便签分类/标签
- [ ] 添加便签导出功能
- [ ] 支持便签同步到云端
- [ ] 添加便签模板
- [ ] 支持便签附件

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 👨‍💻 作者

**wgj6112345** - [GitHub](https://github.com/wgj6112345)

## 🙏 致谢

- 感谢所有贡献者
- 感谢 SwiftUI 社区的优秀资源

---

**享受使用 QuickNote Clone！** 🎉