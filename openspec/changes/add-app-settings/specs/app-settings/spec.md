## ADDED Requirements

### Requirement: Keyboard Shortcuts
系统 SHALL 支持自定义快捷键配置。

#### Scenario: 默认快捷键
- **WHEN** 应用启动
- **THEN** 系统应使用默认快捷键:
  - ⌘ + N: 新建便签
  - ⌘ + W: 关闭当前便签
  - ⌘ + ,: 打开设置
  - ⌘ + /: 切换编辑/预览模式
  - ⌘ + ⇧ + F: 切换置顶状态
  - ⌘ + ⇧ + D: 切换深色/浅色模式

#### Scenario: 自定义快捷键
- **WHEN** 用户在设置中修改快捷键
- **THEN** 系统应保存新的快捷键配置
- **AND** 新快捷键应立即生效
- **AND** 应检查快捷键冲突

#### Scenario: 快捷键冲突检测
- **WHEN** 用户设置的快捷键与系统或其他应用冲突
- **THEN** 系统应显示冲突提示
- **AND** 应建议用户选择其他快捷键

### Requirement: Dark Mode
系统 SHALL 支持深色/浅色模式切换。

#### Scenario: 切换到深色模式
- **WHEN** 用户点击深色模式开关或按下 ⌘ + ⇧ + D 快捷键
- **THEN** 系统应切换到深色模式
- **AND** 所有界面应适配深色主题
- **AND** 切换应流畅,无闪烁

#### Scenario: 切换到浅色模式
- **WHEN** 用户点击浅色模式开关或按下 ⌘ + ⇧ + D 快捷键
- **THEN** 系统应切换到浅色模式
- **AND** 所有界面应适配浅色主题
- **AND** 切换应流畅,无闪烁

#### Scenario: 自动适配系统主题
- **WHEN** 用户选择自动适配系统主题
- **THEN** 系统应跟随系统深色/浅色模式切换
- **AND** 切换应自动进行

### Requirement: Font Size
系统 SHALL 支持字体大小设置。

#### Scenario: 调整字体大小
- **WHEN** 用户在设置中调整字体大小
- **THEN** 系统应更新所有文本的字体大小
- **AND** 字体大小应在 10px 到 24px 之间
- **AND** 更新应立即生效

#### Scenario: 字体大小范围
- **WHEN** 用户尝试将字体大小设置为 < 10px 或 > 24px
- **THEN** 系统应限制字体大小范围为 10px 到 24px
- **AND** 应显示范围提示

### Requirement: Auto Save Interval
系统 SHALL 支持自动保存间隔设置。

#### Scenario: 调整自动保存间隔
- **WHEN** 用户在设置中调整自动保存间隔
- **THEN** 系统应更新自动保存间隔
- **AND** 间隔应在 10 秒到 300 秒之间
- **AND** 更新应立即生效

#### Scenario: 自动保存间隔范围
- **WHEN** 用户尝试将自动保存间隔设置为 < 10 秒或 > 300 秒
- **THEN** 系统应限制间隔范围为 10 秒到 300 秒
- **AND** 应显示范围提示

### Requirement: Always on Top
系统 SHALL 支持置顶状态设置。

#### Scenario: 启用置顶
- **WHEN** 用户启用置顶开关
- **THEN** 系统应将窗口设置为置顶级别
- **AND** 窗口应始终位于其他应用窗口之上

#### Scenario: 禁用置顶
- **WHEN** 用户禁用置顶开关
- **THEN** 系统应将窗口设置为普通级别
- **AND** 窗口可以被其他应用窗口遮挡

### Requirement: Settings Persistence
系统 SHALL 支持设置的持久化保存。

#### Scenario: 保存设置
- **WHEN** 用户修改设置
- **THEN** 系统应自动保存设置
- **AND** 设置应保存到 UserDefaults

#### Scenario: 恢复设置
- **WHEN** 应用启动
- **THEN** 系统应恢复上次保存的设置
- **AND** 如无保存的设置,应使用默认值

#### Scenario: 重置设置
- **WHEN** 用户点击"重置设置"按钮
- **THEN** 系统应显示确认对话框
- **WHEN** 用户确认重置
- **THEN** 系统应恢复所有设置为默认值
- **AND** 应显示"设置已重置"提示

### Requirement: Settings UI
系统 SHALL 提供清晰易用的设置界面。

#### Scenario: 显示设置界面
- **WHEN** 用户点击设置按钮或按下 ⌘ + , 快捷键
- **THEN** 系统应显示设置界面
- **AND** 设置界面应包含以下分组:
  - 快捷键
  - 外观(深色模式、字体大小)
  - 行为(自动保存间隔、置顶状态)

#### Scenario: 设置界面布局
- **WHEN** 显示设置界面
- **THEN** 设置应按分组显示
- **AND** 每个设置应有清晰的标签和说明
- **AND** 设置应有合适的间距和对齐

### Requirement: Performance
系统 SHALL 确保设置的性能符合要求。

#### Scenario: 设置切换性能
- **WHEN** 用户修改设置
- **THEN** 设置应立即生效
- **AND** 响应时间应 < 100ms

#### Scenario: 设置保存性能
- **WHEN** 系统保存设置
- **THEN** 保存操作应在 100ms 内完成