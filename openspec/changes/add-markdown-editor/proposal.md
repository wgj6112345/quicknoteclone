# Change: Add Markdown Editor

## Why
QuickNote Clone 需要支持 Markdown 语法,使用户能够使用格式化文本提升便签的可读性和专业性。

## What Changes
- 实现 Markdown 编辑功能(编辑模式)
- 实现 Markdown 渲染功能(预览模式)
- 支持编辑/预览模式切换
- 支持常用 Markdown 语法(标题、列表、强调、代码、链接、分隔线)
- 提供工具栏快捷按钮

## Impact
- Affected specs: markdown-editor
- Affected code: MarkdownEditor, MarkdownService, NoteDetailView
- Dependencies: note-management(需要便签内容)

## Dependencies
- 依赖 note-management(需要便签内容)
- 其他功能(note-interaction)依赖此功能