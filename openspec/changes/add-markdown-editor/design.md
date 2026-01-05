## Context
QuickNote Clone 需要 Markdown 编辑功能,使用户能够使用格式化文本提升便签的可读性。Markdown 编辑器需要支持编辑和预览两种模式,支持常用 Markdown 语法,并提供良好的用户体验。

## Goals / Non-Goals
- Goals:
  - 实现 Markdown 编辑功能
  - 实现 Markdown 渲染功能
  - 支持编辑/预览模式切换
  - 支持常用 Markdown 语法
  - 渲染延迟 < 200ms
- Non-Goals:
  - 不支持实时预览(编辑/预览分离)
  - 不支持自定义 Markdown 扩展语法
  - 不支持代码高亮(可选功能)

## Decisions
- **Decision 1**: 使用 MarkdownUI 库进行 Markdown 渲染
  - 理由: SwiftUI 原生支持,功能完善,性能优秀
  - 替代方案: Down(功能较少)、自己实现(复杂度高)

- **Decision 2**: 使用 TextEditor 进行编辑
  - 理由: SwiftUI 原生组件,支持多行编辑
  - 替代方案: NSTextView(需要 NSViewRepresentable 包装)

- **Decision 3**: 编辑/预览分离模式
  - 理由: 简化实现,避免实时预览的性能问题
  - 替代方案: 分屏模式(占用空间大)、实时预览(性能影响)

- **Decision 4**: 支持的 Markdown 语法
  - 理由: 覆盖常用场景,保持简洁
  - 支持的语法: 标题、列表、强调、代码、链接、分隔线
  - 不支持的语法: 表格、任务列表、数学公式(可选功能)

## Risks / Trade-offs
- **Risk 1**: MarkdownUI 库可能有兼容性问题
  - 缓解措施: 使用稳定版本(2.0+),充分测试
- **Risk 2**: Markdown 渲染性能可能不足
  - 缓解措施: 使用 LazyVStack 懒加载,避免渲染过长内容
- **Trade-off 1**: 编辑/预览分离可能影响用户体验
  - 缓解措施: 提供快捷键(⌘ + /)快速切换

## Migration Plan
- 无迁移需求(新功能)

## Open Questions
- 无