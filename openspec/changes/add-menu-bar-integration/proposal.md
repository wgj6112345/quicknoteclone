# Change: Add Menu Bar Integration

## Why
QuickNote Clone 需要集成到 macOS 菜单栏,提供快速访问应用的入口,符合 macOS 应用的最佳实践,提升用户体验。

## What Changes
- 在菜单栏显示应用图标
- 点击图标切换主窗口显示/隐藏
- 右键点击图标显示快捷菜单(新建便签、退出应用)
- 隐藏 Dock 图标,使应用仅在菜单栏可见
- 支持深色/浅色模式自适应

## Impact
- Affected specs: menu-bar-integration
- Affected code: AppDelegate, MenuBarManager, Views
- Dependencies: 无(应用入口,其他功能依赖此功能)

## Dependencies
- 无前置依赖
- 其他功能(window-management, note-management)依赖此功能