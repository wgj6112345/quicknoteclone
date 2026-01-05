## ADDED Requirements

### Requirement: Note Collapse/Expand
系统 SHALL 支持便签内容的折叠和展开功能。

#### Scenario: 折叠便签
- **WHEN** 用户点击便签标题栏
- **THEN** 系统应折叠便签内容
- **AND** 仅显示便签标题和操作按钮
- **AND** 折叠按钮应变为展开图标(▶)
- **AND** 折叠应有流畅的动画效果(200ms)

#### Scenario: 展开便签
- **WHEN** 用户点击已折叠便签的标题栏
- **THEN** 系统应展开便签内容
- **AND** 显示完整的便签内容
- **AND** 展开按钮应变为折叠图标(▼)
- **AND** 展开应有流畅的动画效果(200ms)

#### Scenario: 记忆折叠状态
- **WHEN** 用户折叠或展开便签
- **THEN** 系统应保存便签的折叠状态
- **AND** 下次打开应用时,应恢复上次的折叠状态

### Requirement: Hover Effect
系统 SHALL 支持便签的悬停效果。

#### Scenario: 鼠标悬停
- **WHEN** 鼠标悬停在便签卡片上
- **THEN** 便签应有轻微的阴影效果
- **AND** 便签背景应轻微变亮
- **AND** 悬停效果应有流畅的动画(100ms)

#### Scenario: 鼠标移开
- **WHEN** 鼠标移开便签卡片
- **THEN** 便签应恢复默认状态
- **AND** 恢复应有流畅的动画(100ms)

### Requirement: Action Buttons
系统 SHALL 支持操作按钮的显示和隐藏。

#### Scenario: 显示操作按钮
- **WHEN** 鼠标悬停在便签卡片上
- **THEN** 系统应显示操作按钮(折叠/删除)
- **AND** 按钮应有流畅的淡入动画

#### Scenario: 隐藏操作按钮
- **WHEN** 鼠标移开便签卡片
- **THEN** 系统应隐藏操作按钮
- **AND** 按钮应有流畅的淡出动画

#### Scenario: 操作按钮样式
- **WHEN** 显示操作按钮
- **THEN** 折叠按钮应使用 chevron 图标
- **AND** 删除按钮应使用 xmark.circle.fill 图标
- **AND** 按钮应有合适的间距和对齐

### Requirement: Animation Performance
系统 SHALL 确保动画的性能符合要求。

#### Scenario: 折叠/展开动画
- **WHEN** 用户折叠或展开便签
- **THEN** 动画应流畅,帧率 ≥ 60fps
- **AND** 动画时长应为 200ms
- **AND** 应使用 ease-in-out 缓动函数

#### Scenario: 悬停动画
- **WHEN** 鼠标悬停或移开便签
- **THEN** 动画应流畅,帧率 ≥ 60fps
- **AND** 动画时长应为 100ms
- **AND** 应使用 ease-out 缓动函数

#### Scenario: 切换动画
- **WHEN** 用户切换便签
- **THEN** 应有淡入淡出效果
- **AND** 动画时长应为 150ms
- **AND** 动画应流畅,无卡顿

### Requirement: User Feedback
系统 SHALL 提供清晰的用户反馈。

#### Scenario: 折叠状态指示
- **WHEN** 便签处于折叠状态
- **THEN** 折叠按钮应显示展开图标(▶)
- **AND** 图标应清晰可辨

#### Scenario: 展开状态指示
- **WHEN** 便签处于展开状态
- **THEN** 展开按钮应显示折叠图标(▼)
- **AND** 图标应清晰可辨

#### Scenario: 操作反馈
- **WHEN** 用户点击操作按钮
- **THEN** 按钮应有轻微的缩放动画
- **AND** 动画时长应为 100ms

### Requirement: Accessibility
系统 SHALL 支持无障碍访问。

#### Scenario: 键盘导航
- **WHEN** 用户使用 Tab 键导航
- **THEN** 系统应支持键盘导航到便签卡片
- **AND** 应支持 Enter 键切换折叠/展开状态

#### Scenario: VoiceOver 支持
- **WHEN** 用户使用 VoiceOver
- **THEN** 系统应提供清晰的语音提示
- **AND** 应说明便签的折叠状态