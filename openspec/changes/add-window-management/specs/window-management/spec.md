## ADDED Requirements

### Requirement: Floating Window
系统 SHALL 提供置顶窗口功能,使主窗口始终位于其他应用窗口之上。

#### Scenario: 窗口置顶显示
- **WHEN** 应用启动
- **THEN** 主窗口应设置为置顶级别(.floating)
- **AND** 窗口应始终位于其他应用窗口之上

#### Scenario: 切换置顶状态
- **WHEN** 用户按下 ⌘ + ⇧ + F 快捷键
- **THEN** 系统应切换窗口的置顶状态
- **AND** 应显示当前置顶状态的提示

#### Scenario: 多窗口置顶
- **WHEN** 有多个应用窗口
- **THEN** QuickNote Clone 窗口应始终位于最上层
- **AND** 不应被其他应用窗口遮挡

### Requirement: Window Dragging
系统 SHALL 支持用户拖拽移动窗口位置。

#### Scenario: 拖拽窗口
- **WHEN** 用户拖拽窗口标题栏
- **THEN** 窗口应跟随鼠标移动
- **AND** 拖拽应流畅,无卡顿

#### Scenario: 拖拽限制
- **WHEN** 用户拖拽窗口到屏幕边缘
- **THEN** 窗口应保持在屏幕范围内
- **AND** 不应完全移出屏幕

#### Scenario: 多显示器拖拽
- **WHEN** 用户有多个显示器
- **THEN** 窗口应支持跨显示器拖拽
- **AND** 拖拽应流畅

### Requirement: Window Resizing
系统 SHALL 支持用户调整窗口大小。

#### Scenario: 调整窗口大小
- **WHEN** 用户拖拽窗口右下角
- **THEN** 窗口应跟随鼠标调整大小
- **AND** 调整应流畅,无卡顿

#### Scenario: 最小尺寸限制
- **WHEN** 用户尝试将窗口调整到小于 300×400
- **THEN** 系统应限制窗口最小尺寸为 300×400

#### Scenario: 最大尺寸限制
- **WHEN** 用户尝试将窗口调整到大于 800×1200
- **THEN** 系统应限制窗口最大尺寸为 800×1200

### Requirement: Window Memory
系统 SHALL 记住用户调整的窗口位置和大小,并在下次启动时恢复。

#### Scenario: 保存窗口位置和大小
- **WHEN** 用户调整窗口位置或大小
- **THEN** 系统应自动保存窗口位置和大小
- **AND** 应保存到 UserDefaults

#### Scenario: 恢复窗口位置和大小
- **WHEN** 应用启动
- **THEN** 系统应恢复上次保存的窗口位置和大小
- **AND** 如窗口位置超出屏幕范围,应调整到默认位置

#### Scenario: 首次启动
- **WHEN** 应用首次启动(无保存的窗口位置)
- **THEN** 系统应使用默认窗口位置(100, 100)和大小(400, 600)

### Requirement: Multi-Monitor Support
系统 SHALL 支持多显示器环境。

#### Scenario: 多显示器显示
- **WHEN** 用户有多个显示器
- **THEN** 窗口应支持在任意显示器上显示
- **AND** 窗口位置应正确映射到显示器坐标

#### Scenario: 显示器断开连接
- **WHEN** 显示器断开连接
- **THEN** 如窗口在该显示器上,系统应将窗口移动到主显示器
- **AND** 应保持窗口大小不变

### Requirement: Window Behavior
系统 SHALL 提供合理的窗口行为。

#### Scenario: 窗口最小化
- **WHEN** 用户点击最小化按钮
- **THEN** 窗口应最小化到菜单栏
- **AND** 应隐藏主窗口但保持应用运行

#### Scenario: 窗口关闭
- **WHEN** 用户点击关闭按钮
- **THEN** 窗口应关闭
- **AND** 应用应继续运行(不退出)
- **AND** 菜单栏图标应保持可见

#### Scenario: 窗口激活
- **WHEN** 用户点击菜单栏图标显示窗口
- **THEN** 窗口应成为活动窗口
- **AND** 应接收键盘输入

### Requirement: Performance
系统 SHALL 确保窗口管理的性能符合要求。

#### Scenario: 拖拽性能
- **WHEN** 用户拖拽窗口
- **THEN** 拖拽应流畅,帧率 ≥ 60fps

#### Scenario: 调整大小性能
- **WHEN** 用户调整窗口大小
- **THEN** 调整应流畅,帧率 ≥ 60fps

#### Scenario: 窗口切换性能
- **WHEN** 用户切换窗口显示/隐藏
- **THEN** 切换应流畅,无延迟