# Change: Add Note Interaction

## Why
QuickNote Clone 需要提供流畅的便签交互体验,包括折叠/展开、悬停效果、动画等,提升用户体验。

## What Changes
- 实现便签折叠/展开功能
- 实现便签悬停效果
- 实现操作按钮显示/隐藏
- 实现流畅的动画效果
- 记忆每个便签的折叠状态

## Impact
- Affected specs: note-interaction
- Affected code: NoteCard, NoteListView
- Dependencies: note-management(需要便签数据)

## Dependencies
- 依赖 note-management(需要便签数据)
- 其他功能(app-settings)依赖此功能