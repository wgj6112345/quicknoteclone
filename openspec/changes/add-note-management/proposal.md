# Change: Add Note Management

## Why
QuickNote Clone 的核心功能是便签管理,用户需要能够创建、编辑、删除和查看便签,这是应用的核心价值。

## What Changes
- 实现便签的创建、编辑、删除功能
- 实现便签列表展示
- 实现便签切换功能
- 实现自动保存机制
- 支持至少 50 个便签

## Impact
- Affected specs: note-management
- Affected code: NoteService, NoteListViewModel, NoteListView, NoteCard
- Dependencies: data-persistence(数据存储), window-management(窗口容器)

## Dependencies
- 依赖 data-persistence(需要数据存储)
- 依赖 window-management(需要窗口容器)
- 其他功能(markdown-editor, note-interaction)依赖此功能