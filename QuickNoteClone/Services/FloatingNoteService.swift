import AppKit
import SwiftUI

/// 悬浮便签服务
@MainActor
class FloatingNoteService {
    static let shared = FloatingNoteService()
    
    private var floatingWindows: [UUID: NSWindow] = [:]
    
    private init() {}
    
    /// 显示悬浮便签窗口
    func showFloatingNote(_ note: Note, onUpdate: @escaping (Note) -> Void) {
        // 如果窗口已存在,显示它
        if let window = floatingWindows[note.id] {
            window.makeKeyAndOrderFront(nil)
            return
        }
        
        // 创建新窗口
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 400),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        
        window.title = note.title
        window.level = .floating
        window.isReleasedWhenClosed = false
        window.isMovableByWindowBackground = true
        
        // 设置窗口内容
        let contentView = FloatingNoteView(note: note, onUpdate: onUpdate)
        window.contentViewController = NSHostingController(rootView: contentView)
        
        // 居中显示
        window.center()
        
        // 监听窗口关闭
        NotificationCenter.default.addObserver(
            forName: NSWindow.willCloseNotification,
            object: window,
            queue: .main
        ) { [weak self] _ in
            self?.removeFloatingWindow(noteId: note.id)
        }
        
        // 保存窗口引用
        floatingWindows[note.id] = window
        
        // 显示窗口
        window.makeKeyAndOrderFront(nil)
    }
    
    /// 隐藏悬浮便签窗口
    func hideFloatingNote(_ noteId: UUID) {
        floatingWindows[noteId]?.orderOut(nil)
    }
    
    /// 关闭悬浮便签窗口
    func closeFloatingNote(_ noteId: UUID) {
        floatingWindows[noteId]?.close()
        removeFloatingWindow(noteId: noteId)
    }
    
    /// 移除悬浮窗口引用
    private func removeFloatingWindow(noteId: UUID) {
        floatingWindows.removeValue(forKey: noteId)
    }
    
    /// 关闭所有悬浮窗口
    func closeAllFloatingNotes() {
        floatingWindows.values.forEach { $0.close() }
        floatingWindows.removeAll()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

/// 悬浮便签视图
struct FloatingNoteView: View {
    @State private var note: Note
    let onUpdate: (Note) -> Void
    
    init(note: Note, onUpdate: @escaping (Note) -> Void) {
        self._note = State(initialValue: note)
        self.onUpdate = onUpdate
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 标题栏
            HStack {
                TextField("标题", text: $note.title)
                    .textFieldStyle(.plain)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                Button(action: {
                    onUpdate(note)
                }) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.borderless)
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor))
            
            Divider()
            
            // 内容编辑器
            VStack(alignment: .leading, spacing: 8) {
                TextEditor(text: $note.content)
                    .font(.system(size: 14))
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onChange(of: note.content) { _, _ in
            onUpdate(note)
        }
        .onChange(of: note.title) { _, _ in
            onUpdate(note)
        }
    }
}