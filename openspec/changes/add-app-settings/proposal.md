# Change: Add App Settings

## Why
QuickNote Clone 需要提供应用设置功能,让用户能够自定义应用行为,如快捷键、深色模式、字体大小等,提升用户体验。

## What Changes
- 实现快捷键配置功能
- 实现深色/浅色模式切换
- 实现字体大小设置
- 实现自动保存间隔设置
- 实现置顶状态设置

## Impact
- Affected specs: app-settings
- Affected code: AppSettings, AppViewModel, SettingsView
- Dependencies: data-persistence(需要保存设置), window-management(影响窗口), markdown-editor(影响编辑器)

## Dependencies
- 依赖 data-persistence(需要保存设置)
- 影响 window-management(置顶状态)
- 影响 markdown-editor(字体大小)