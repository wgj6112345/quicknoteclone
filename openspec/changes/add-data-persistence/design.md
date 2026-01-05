## Context
QuickNote Clone 是一个 macOS 桌面便签应用,需要可靠的数据持久化机制来保存用户数据。数据存储需要满足以下要求:
- 轻量级,无需复杂的数据库
- 快速读写,响应时间 < 200ms
- 可靠性高,数据保存成功率 100%
- 支持自动保存和手动保存

## Goals / Non-Goals
- Goals:
  - 实现便签数据的本地持久化
  - 实现应用设置的本地持久化
  - 支持数据的自动保存和恢复
  - 数据保存成功率 100%
- Non-Goals:
  - 不支持云同步(云同步是 P2 功能)
  - 不支持数据库(使用 UserDefaults + JSON)
  - 不支持数据加密(可选功能)

## Decisions
- **Decision 1**: 使用 UserDefaults 作为数据存储
  - 理由: 轻量级,无需额外依赖,满足需求
  - 替代方案: CoreData(过于复杂)、SQLite(需要额外依赖)

- **Decision 2**: 使用 JSON 格式序列化数据
  - 理由: 可读性好,易于调试,支持数据导出
  - 替代方案: Property List(可读性差)、Binary(不可读)

- **Decision 3**: 使用 Actor 确保线程安全
  - 理由: 避免数据竞争,确保数据一致性
  - 替代方案: DispatchQueue(代码复杂度高)

- **Decision 4**: 自动保存间隔为 30 秒或内容变更时立即保存
  - 理由: 平衡性能和数据安全
  - 替代方案: 仅定时保存(数据丢失风险)、仅实时保存(性能影响)

## Risks / Trade-offs
- **Risk 1**: UserDefaults 有大小限制(约 4MB)
  - 缓解措施: 限制便签数量(最多 50 个)和内容长度(最多 10000 字符)
- **Risk 2**: JSON 序列化可能失败
  - 缓解措施: 使用 try-catch 处理错误,提供友好的错误提示
- **Trade-off 1**: 自动保存可能影响性能
  - 缓解措施: 使用 debounce 防抖,延迟 300ms 后保存

## Migration Plan
- 无迁移需求(新功能)
- 如需升级数据格式,在 NoteRepository 中添加版本号和迁移逻辑

## Open Questions
- 无