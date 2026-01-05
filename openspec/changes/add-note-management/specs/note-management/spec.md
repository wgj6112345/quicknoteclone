## ADDED Requirements

### Requirement: Note Creation
系统 SHALL 支持用户创建新便签。

#### Scenario: 创建新便签
- **WHEN** 用户点击"新建便签"按钮或按下 ⌘ + N 快捷键
- **THEN** 系统应创建新便签
- **AND** 便签应使用默认标题"新便签"
- **AND** 便签内容应为空
- **AND** 新便签应插入到列表顶部
- **AND** 应自动聚焦到新便签

#### Scenario: 快速创建便签
- **WHEN** 用户右键菜单栏图标选择"新建便签"
- **THEN** 系统应创建新便签
- **AND** 应显示主窗口并聚焦到新便签

### Requirement: Note Editing
系统 SHALL 支持用户编辑便签内容。

#### Scenario: 编辑便签标题
- **WHEN** 用户点击便签标题
- **THEN** 标题应变为可编辑状态
- **AND** 用户应能够修改标题
- **AND** 标题最大长度应为 100 字符

#### Scenario: 编辑便签内容
- **WHEN** 用户点击便签内容区域
- **THEN** 光标应定位到内容区域
- **AND** 用户应能够编辑内容
- **AND** 内容最大长度应为 10000 字符

#### Scenario: 自动保存
- **WHEN** 用户编辑便签内容
- **THEN** 系统应在 300ms 后自动保存(防抖)
- **AND** 应显示"已保存"提示

### Requirement: Note Deletion
系统 SHALL 支持用户删除便签。

#### Scenario: 删除便签
- **WHEN** 用户点击便签的删除按钮
- **THEN** 系统应显示确认对话框
- **AND** 对话框应显示"确定要删除此便签吗?"
- **WHEN** 用户确认删除
- **THEN** 系统应删除便签
- **AND** 便签应从列表中移除
- **AND** 数据应从本地删除

#### Scenario: 取消删除
- **WHEN** 用户点击删除按钮
- **THEN** 系统应显示确认对话框
- **WHEN** 用户取消删除
- **THEN** 系统应保留便签
- **AND** 便签应保持在列表中

### Requirement: Note List Display
系统 SHALL 支持便签列表的展示。

#### Scenario: 显示便签列表
- **WHEN** 应用启动
- **THEN** 系统应显示所有便签列表
- **AND** 便签应按更新时间降序排列
- **AND** 列表应支持滚动

#### Scenario: 空状态显示
- **WHEN** 没有任何便签
- **THEN** 系统应显示空状态提示
- **AND** 应显示"还没有便签"文字
- **AND** 应显示"点击上方按钮创建第一个便签"提示
- **AND** 应显示便签图标

#### Scenario: 加载状态显示
- **WHEN** 正在加载便签数据
- **THEN** 系统应显示加载指示器
- **AND** 应显示"加载中..."文字

### Requirement: Note Switching
系统 SHALL 支持用户在便签之间切换。

#### Scenario: 切换到便签
- **WHEN** 用户点击便签卡片
- **THEN** 系统应切换到该便签
- **AND** 应高亮显示当前便签
- **AND** 应显示便签的完整内容

#### Scenario: 键盘导航
- **WHEN** 用户按下 ⌘ + ↑ 或 ⌘ + ↓
- **THEN** 系统应切换到上一个/下一个便签
- **AND** 应高亮显示当前便签

### Requirement: Note Limit
系统 SHALL 支持至少 50 个便签。

#### Scenario: 创建便签
- **WHEN** 用户创建便签
- **THEN** 系统应支持至少 50 个便签
- **AND** 创建操作应即时生效

#### Scenario: 便签数量限制提示
- **WHEN** 用户尝试创建超过 50 个便签
- **THEN** 系统应显示提示
- **AND** 提示应显示"已达到便签数量上限(50个)"

### Requirement: Note Data Integrity
系统 SHALL 确保便签数据的完整性。

#### Scenario: 数据保存
- **WHEN** 用户编辑便签
- **THEN** 系统应自动保存数据
- **AND** 保存成功率应为 100%

#### Scenario: 数据恢复
- **WHEN** 应用重启
- **THEN** 系统应恢复所有便签数据
- **AND** 数据应完整,无丢失

### Requirement: Performance
系统 SHALL 确保便签管理的性能符合要求。

#### Scenario: 创建便签性能
- **WHEN** 用户创建便签
- **THEN** 创建操作应在 100ms 内完成

#### Scenario: 删除便签性能
- **WHEN** 用户删除便签
- **THEN** 删除操作应在 100ms 内完成

#### Scenario: 切换便签性能
- **WHEN** 用户切换便签
- **THEN** 切换操作应在 100ms 内完成