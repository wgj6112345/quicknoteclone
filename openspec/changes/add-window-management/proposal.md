# Change: Add Window Management

## Why
QuickNote Clone 需要提供灵活的窗口管理功能,包括置顶显示、拖拽移动、大小调整等,确保用户能够在任何工作场景下方便地访问便签。

## What Changes
- 实现主窗口置顶显示功能
- 支持窗口拖拽移动
- 支持窗口大小调整
- 实现窗口位置/大小记忆功能
- 支持多显示器环境

## Impact
- Affected specs: window-management
- Affected code: MainWindow, WindowService, Views
- Dependencies: menu-bar-integration(应用入口)

## Dependencies
- 依赖 menu-bar-integration(需要主窗口)
- 其他功能(note-management)依赖此功能