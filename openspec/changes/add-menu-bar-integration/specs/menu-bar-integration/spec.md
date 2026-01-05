## ADDED Requirements

### Requirement: Menu Bar Icon
系统 SHALL 在 macOS 菜单栏显示应用图标,作为应用的快速访问入口。

#### Scenario: 显示菜单栏图标
- **WHEN** 应用启动
- **THEN** 系统应在菜单栏显示应用图标
- **AND** 图标应使用 SF Symbols 的 "note.text" 符号
- **AND** 图标应始终可见

#### Scenario: 图标状态变化
- **WHEN** 有便签数据
- **THEN** 图标应显示为黄色(经典便签色)
- **WHEN** 无便签数据
- **THEN** 图标应显示为灰色

#### Scenario: 深色/浅色模式自适应
- **WHEN** 系统切换深色/浅色模式
- **THEN** 菜单栏图标应自动适配系统主题
- **AND** 图标颜色应符合系统主题规范

### Requirement: Window Toggle
系统 SHALL 支持通过点击菜单栏图标切换主窗口的显示/隐藏状态。

#### Scenario: 显示主窗口
- **WHEN** 用户点击菜单栏图标且窗口未显示
- **THEN** 系统应显示主窗口
- **AND** 窗口应显示在菜单栏图标下方
- **AND** 响应时间应 < 100ms

#### Scenario: 隐藏主窗口
- **WHEN** 用户点击菜单栏图标且窗口已显示
- **THEN** 系统应隐藏主窗口
- **AND** 响应时间应 < 100ms

#### Scenario: 点击外部区域隐藏窗口
- **WHEN** 用户点击窗口外部区域
- **THEN** 系统应自动隐藏主窗口

#### Scenario: 按 ESC 键隐藏窗口
- **WHEN** 用户按下 ESC 键
- **THEN** 系统应隐藏主窗口

### Requirement: Context Menu
系统 SHALL 支持右键点击菜单栏图标显示快捷菜单。

#### Scenario: 显示快捷菜单
- **WHEN** 用户右键点击菜单栏图标
- **THEN** 系统应显示快捷菜单
- **AND** 菜单应包含以下选项:
  - 📝 新建便签
  - 🔍 搜索便签
  - ⚙️ 设置
  - ❌ 退出应用

#### Scenario: 新建便签
- **WHEN** 用户在快捷菜单中选择"新建便签"
- **THEN** 系统应创建新便签
- **AND** 应显示主窗口并聚焦到新便签

#### Scenario: 搜索便签
- **WHEN** 用户在快捷菜单中选择"搜索便签"
- **THEN** 系统应显示主窗口
- **AND** 应聚焦到搜索框

#### Scenario: 打开设置
- **WHEN** 用户在快捷菜单中选择"设置"
- **THEN** 系统应显示设置窗口

#### Scenario: 退出应用
- **WHEN** 用户在快捷菜单中选择"退出应用"
- **THEN** 系统应退出应用
- **AND** 应保存所有数据

### Requirement: Dock Icon Hiding
系统 SHALL 隐藏 Dock 图标,使应用仅在菜单栏可见。

#### Scenario: 隐藏 Dock 图标
- **WHEN** 应用启动
- **THEN** 系统应隐藏 Dock 图标
- **AND** 应用应设置 activation policy 为 .accessory

#### Scenario: 应用生命周期管理
- **WHEN** 所有窗口关闭
- **THEN** 应用应继续运行(不退出)
- **AND** 菜单栏图标应保持可见

### Requirement: Application Lifecycle
系统 SHALL 正确处理应用的生命周期事件。

#### Scenario: 应用启动
- **WHEN** 应用启动
- **THEN** 系统应初始化菜单栏图标
- **AND** 应加载所有便签数据
- **AND** 应恢复应用设置

#### Scenario: 应用终止
- **WHEN** 应用终止(用户退出或系统关闭)
- **THEN** 系统应保存所有便签数据
- **AND** 应保存应用设置
- **AND** 应清理资源

#### Scenario: 应用休眠/唤醒
- **WHEN** 应用休眠或唤醒
- **THEN** 系统应保持数据一致性
- **AND** 不应丢失未保存的数据

### Requirement: Performance
系统 SHALL 确保菜单栏集成的性能符合要求。

#### Scenario: 点击响应时间
- **WHEN** 用户点击菜单栏图标
- **THEN** 响应时间应 < 100ms

#### Scenario: 内存占用
- **WHEN** 应用运行
- **THEN** 内存占用应 < 50MB(空闲时)

#### Scenario: CPU 占用
- **WHEN** 应用空闲
- **THEN** CPU 占用应 < 5%