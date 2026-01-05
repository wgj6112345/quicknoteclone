## ADDED Requirements

### Requirement: Markdown Editing
系统 SHALL 支持 Markdown 语法的编辑功能。

#### Scenario: 编辑 Markdown 内容
- **WHEN** 用户在编辑模式下输入 Markdown 文本
- **THEN** 系统应显示原始 Markdown 文本
- **AND** 应使用等宽字体
- **AND** 应支持多行编辑

#### Scenario: 编辑模式默认状态
- **WHEN** 用户打开便签
- **THEN** 系统应默认进入编辑模式
- **AND** 光标应定位到内容区域

### Requirement: Markdown Rendering
系统 SHALL 支持 Markdown 语法的渲染功能。

#### Scenario: 渲染 Markdown 内容
- **WHEN** 用户切换到预览模式
- **THEN** 系统应渲染 Markdown 文本为富文本
- **AND** 渲染延迟应 < 200ms
- **AND** 渲染应准确,无格式错误

#### Scenario: 支持标题语法
- **WHEN** 用户输入 `# 标题`、`## 标题`、`### 标题`
- **THEN** 系统应渲染为不同级别的标题
- **AND** 标题应有不同的字号和字重

#### Scenario: 支持列表语法
- **WHEN** 用户输入 `- 列表项`、`* 列表项`、`1. 列表项`
- **THEN** 系统应渲染为无序列表或有序列表
- **AND** 列表应有正确的缩进

#### Scenario: 支持强调语法
- **WHEN** 用户输入 `**粗体**`、`*斜体*`
- **THEN** 系统应渲染为粗体或斜体文本
- **AND** 强调应有正确的样式

#### Scenario: 支持代码语法
- **WHEN** 用户输入 `` `代码` `` 或 ```代码块```
- **THEN** 系统应渲染为行内代码或代码块
- **AND** 代码应使用等宽字体
- **AND** 代码块应有背景色

#### Scenario: 支持链接语法
- **WHEN** 用户输入 `[链接文本](url)`
- **THEN** 系统应渲染为可点击的链接
- **AND** 链接应有正确的颜色和下划线

#### Scenario: 支持分隔线语法
- **WHEN** 用户输入 `---`
- **THEN** 系统应渲染为分隔线
- **AND** 分隔线应横跨整个宽度

### Requirement: Mode Switching
系统 SHALL 支持编辑模式和预览模式的切换。

#### Scenario: 切换到编辑模式
- **WHEN** 用户点击编辑按钮或按下 ⌘ + E 快捷键
- **THEN** 系统应切换到编辑模式
- **AND** 应显示原始 Markdown 文本
- **AND** 编辑按钮应高亮

#### Scenario: 切换到预览模式
- **WHEN** 用户点击预览按钮或按下 ⌘ + P 快捷键
- **THEN** 系统应切换到预览模式
- **AND** 应显示渲染后的富文本
- **AND** 预览按钮应高亮

#### Scenario: 快速切换模式
- **WHEN** 用户双击便签内容区域
- **THEN** 系统应切换编辑/预览模式
- **AND** 切换应有流畅的动画效果

### Requirement: Toolbar
系统 SHALL 提供工具栏,方便用户快速插入 Markdown 语法。

#### Scenario: 插入粗体
- **WHEN** 用户点击粗体按钮或按下 ⌘ + B 快捷键
- **THEN** 系统应在光标位置插入 `**粗体**`
- **AND** 如有选中文本,应将选中文本包裹在 `**` 中

#### Scenario: 插入斜体
- **WHEN** 用户点击斜体按钮或按下 ⌘ + I 快捷键
- **THEN** 系统应在光标位置插入 `*斜体*`
- **AND** 如有选中文本,应将选中文本包裹在 `*` 中

#### Scenario: 插入代码
- **WHEN** 用户点击代码按钮或按下 ⌘ + ⇧ + K 快捷键
- **THEN** 系统应在光标位置插入 `` `代码` ``
- **AND** 如有选中文本,应将选中文本包裹在 ` ` ` 中

#### Scenario: 插入链接
- **WHEN** 用户点击链接按钮或按下 ⌘ + K 快捷键
- **THEN** 系统应在光标位置插入 `[链接文本](url)`
- **AND** 应选中"链接文本"部分

### Requirement: Custom Theme
系统 SHALL 支持自定义 Markdown 渲染主题。

#### Scenario: 自定义主题
- **WHEN** 系统渲染 Markdown
- **THEN** 应使用自定义主题
- **AND** 主题应适配深色/浅色模式
- **AND** 主题应使用系统字体

#### Scenario: 代码块样式
- **WHEN** 系统渲染代码块
- **THEN** 代码块应有背景色
- **AND** 代码应使用等宽字体
- **AND** 代码块应有圆角边框

### Requirement: Performance
系统 SHALL 确保 Markdown 编辑和渲染的性能符合要求。

#### Scenario: 编辑性能
- **WHEN** 用户编辑 Markdown 内容
- **THEN** 编辑应流畅,无卡顿
- **AND** 输入延迟应 < 50ms

#### Scenario: 渲染性能
- **WHEN** 用户切换到预览模式
- **THEN** 渲染延迟应 < 200ms
- **AND** 渲染应流畅,无卡顿

#### Scenario: 大文件性能
- **WHEN** 便签内容超过 10000 字符
- **THEN** 渲染延迟应 < 500ms
- **AND** 系统应保持响应