# Project Context

## Purpose
QuickNote Clone 是一款轻量级的 macOS 桌面便签应用,通过置顶悬浮窗口提供快速记录和管理便签的功能,支持 Markdown 语法,保持简洁高效的用户体验。

## Tech Stack
- **开发语言**: Swift 5.9+
- **UI 框架**: SwiftUI (macOS 14+)
- **数据存储**: UserDefaults + JSON
- **Markdown 渲染**: MarkdownUI 2.0+
- **架构模式**: MVVM + Clean Architecture
- **依赖管理**: Swift Package Manager
- **构建工具**: Xcode 15.0+

## Project Conventions

### Code Style
- **命名规范**:
  - 类名: 大驼峰(PascalCase),如 `NoteService`
  - 方法名: 小驼峰(camelCase),如 `createNote()`
  - 变量名: 小驼峰(camelCase),如 `noteTitle`
  - 常量: 全大写加下划线,如 `MAX_TITLE_LENGTH`
  - 协议名: 大驼峰,如 `NoteRepository`
  - 枚举值: 小驼峰,如 `case yellow`
- **代码组织**:
  - 单文件单类/结构体
  - 文件名与类名一致
  - 使用 `// MARK:` 分组代码
  - 导入顺序: 系统框架 → 第三方库 → 项目模块
- **注释规范**:
  - 公共 API 必须包含文档注释
  - 行内注释解释"为什么"而非"做什么"
  - 使用 `///` 进行文档注释

### Architecture Patterns
遵循 **SOLID** 原则和 **Clean Architecture**:
- **依赖倒置原则(DIP)**: 高层模块不依赖低层模块,两者都依赖抽象(Protocols)
- **单一职责原则(SRP)**: 每个 Class/Struct 仅负责一个功能
- **开闭原则(OCP)**: 对扩展开放,对修改关闭
- **六边形架构**: 使用 Ports(接口)和 Adapters(实现)模式
- **MVVM**: View → ViewModel → Model 单向数据流

### Testing Strategy
- **单元测试**: 使用 XCTest 框架,测试覆盖率 ≥ 90%
- **UI 测试**: 使用 XCUITest 框架,测试关键用户流程
- **测试原则**:
  - 遵循 AAA 模式(Arrange-Act-Assert)
  - 使用 Mock/Stub 隔离依赖
  - 测试命名清晰,表达意图

### Git Workflow
- **提交规范**: 使用 Conventional Commits
  ```
  feat: 添加 Markdown 编辑功能
  fix: 修复窗口置顶失效问题
  docs: 更新 API 文档
  style: 代码格式化
  refactor: 重构 NoteService
  test: 添加 NoteService 单元测试
  chore: 更新依赖版本
  ```
- **分支管理**:
  - `main`: 主分支,稳定版本
  - `develop`: 开发分支
  - `feature/*`: 功能分支
  - `hotfix/*`: 热修复分支

## Domain Context
- **便签(Note)**: 核心业务实体,包含标题、内容、创建时间、更新时间、折叠状态
- **便签颜色(NoteColor)**: 5 种预设颜色(黄、蓝、绿、粉、紫)
- **应用设置(AppSettings)**: 窗口位置、大小、深色模式、置顶状态等用户偏好
- **Markdown 渲染**: 支持标题、列表、强调、代码、链接、分隔线等语法

## Important Constraints
- **性能要求**:
  - 应用启动时间 < 3 秒
  - 窗口显示/隐藏延迟 < 100ms
  - Markdown 渲染延迟 < 200ms
  - 搜索响应时间 < 200ms
  - 内存占用 < 50MB
- **兼容性要求**:
  - macOS 版本: 14.0 及以上
  - 架构: Intel + Apple Silicon(通用二进制)
- **安全性要求**:
  - 数据加密存储(可选)
  - 无网络请求(除非云同步)
  - 代码签名,防止篡改
- **可用性要求**:
  - 界面简洁,学习成本 < 5 分钟
  - 操作流程直观,无需说明书
  - 支持键盘操作,减少鼠标依赖

## External Dependencies
- **MarkdownUI**: https://github.com/gonzalezreal/swift-markdown-ui (版本 2.0+)
- **系统框架**:
  - Foundation
  - AppKit
  - SwiftUI
  - Combine
- **开发工具**:
  - Xcode 15.0+
  - Swift Package Manager
