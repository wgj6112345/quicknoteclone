## ADDED Requirements

### Requirement: Data Persistence
系统 SHALL 提供可靠的本地数据持久化功能,用于保存便签数据和应用设置。

#### Scenario: 保存便签数据
- **WHEN** 用户创建或修改便签
- **THEN** 系统应自动将便签数据保存到本地
- **AND** 保存操作应在 200ms 内完成
- **AND** 保存成功率应为 100%

#### Scenario: 恢复便签数据
- **WHEN** 应用启动时
- **THEN** 系统应从本地加载所有便签数据
- **AND** 数据应完整恢复,无丢失
- **AND** 恢复操作应在 1 秒内完成

#### Scenario: 保存应用设置
- **WHEN** 用户修改应用设置(如窗口位置、大小、深色模式)
- **THEN** 系统应自动将设置保存到本地
- **AND** 设置应在下次启动时恢复

#### Scenario: 自动保存机制
- **WHEN** 便签内容发生变化
- **THEN** 系统应在 300ms 后自动保存(防抖)
- **OR** 系统应每 30 秒自动保存一次

#### Scenario: 数据导出
- **WHEN** 用户选择导出便签数据
- **THEN** 系统应将数据导出为 JSON 格式
- **AND** 导出的数据应包含所有便签和设置

#### Scenario: 数据导入
- **WHEN** 用户选择导入便签数据
- **THEN** 系统应从 JSON 文件导入数据
- **AND** 导入的数据应合并到现有数据中
- **AND** 如数据格式错误,应显示友好的错误提示

### Requirement: Data Model
系统 SHALL 定义清晰的数据模型,用于表示便签和应用设置。

#### Scenario: 便签数据结构
- **WHEN** 创建便签对象
- **THEN** 便签应包含以下字段:
  - id: UUID(唯一标识)
  - title: String(标题,最大 100 字符)
  - content: String(Markdown 内容,最大 10000 字符)
  - createdAt: Date(创建时间)
  - updatedAt: Date(更新时间)
  - isCollapsed: Bool(折叠状态)
  - color: NoteColor?(便签颜色,可选)

#### Scenario: 应用设置数据结构
- **WHEN** 创建应用设置对象
- **THEN** 设置应包含以下字段:
  - windowPosition: CGPoint(窗口位置)
  - windowSize: CGSize(窗口大小)
  - isDarkMode: Bool(深色模式)
  - isAlwaysOnTop: Bool(置顶状态)
  - fontSize: Double(字体大小)
  - autoSaveInterval: TimeInterval(自动保存间隔)

### Requirement: Data Repository
系统 SHALL 提供数据仓库接口,用于抽象数据访问逻辑。

#### Scenario: 获取所有便签
- **WHEN** 调用 fetchAll() 方法
- **THEN** 系统应返回所有便签列表
- **AND** 便签应按更新时间降序排列

#### Scenario: 根据 ID 获取便签
- **WHEN** 调用 fetch(by: UUID) 方法
- **THEN** 系统应返回指定 ID 的便签
- **AND** 如便签不存在,应返回 nil

#### Scenario: 保存便签
- **WHEN** 调用 save(_ note: Note) 方法
- **THEN** 系统应保存便签到本地
- **AND** 如便签已存在,应更新数据
- **AND** 如便签不存在,应创建新便签

#### Scenario: 删除便签
- **WHEN** 调用 delete(_ id: UUID) 方法
- **THEN** 系统应从本地删除指定 ID 的便签
- **AND** 如便签不存在,应忽略操作

### Requirement: Thread Safety
系统 SHALL 确保数据访问的线程安全,避免数据竞争。

#### Scenario: 并发保存便签
- **WHEN** 多个线程同时保存便签
- **THEN** 系统应串行化保存操作
- **AND** 数据应保持一致性

#### Scenario: 并发读取便签
- **WHEN** 多个线程同时读取便签
- **THEN** 系统应安全返回数据
- **AND** 不应出现数据竞争错误

### Requirement: Error Handling
系统 SHALL 提供完善的错误处理机制,确保数据操作的可靠性。

#### Scenario: 保存失败
- **WHEN** 保存操作失败(如磁盘空间不足)
- **THEN** 系统应抛出明确的错误
- **AND** 应向用户显示友好的错误提示

#### Scenario: 加载失败
- **WHEN** 加载操作失败(如数据损坏)
- **THEN** 系统应抛出明确的错误
- **AND** 应尝试恢复默认数据
- **AND** 应向用户显示友好的错误提示

#### Scenario: 数据格式错误
- **WHEN** 导入的数据格式错误
- **THEN** 系统应拒绝导入
- **AND** 应显示具体的错误信息