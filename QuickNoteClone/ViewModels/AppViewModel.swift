import SwiftUI
import Combine

/// 应用视图模型
@MainActor
class AppViewModel: ObservableObject {
    static let shared = AppViewModel()

    @Published var appSettings: AppSettings
    @Published var isDarkMode: Bool
    @Published var isAlwaysOnTop: Bool

    private let noteService: NoteService
    private var cancellables = Set<AnyCancellable>()

    init(noteService: NoteService = .shared) {
        self.noteService = noteService

        // 使用默认值初始化
        let defaultSettings = AppSettings()
        self.appSettings = defaultSettings
        self.isDarkMode = defaultSettings.isDarkMode
        self.isAlwaysOnTop = defaultSettings.isAlwaysOnTop

        // 异步加载设置
        Task {
            let loadedSettings = await noteService.getSettings()
            await MainActor.run {
                self.appSettings = loadedSettings
                self.isDarkMode = loadedSettings.isDarkMode
                self.isAlwaysOnTop = loadedSettings.isAlwaysOnTop
            }
        }

        setupBindings()
    }

    // MARK: - Public Methods

    func saveSettings() async {
        do {
            appSettings.isDarkMode = isDarkMode
            appSettings.isAlwaysOnTop = isAlwaysOnTop
            try await noteService.saveSettings(appSettings)
        } catch {
            print("保存设置失败: \(error.localizedDescription)")
        }
    }

    func resetSettings() async {
        appSettings = AppSettings()
        isDarkMode = appSettings.isDarkMode
        isAlwaysOnTop = appSettings.isAlwaysOnTop
        try? await noteService.saveSettings(appSettings)
    }

    // MARK: - Private Methods

    private func setupBindings() {
        // 监听深色模式变化
        $isDarkMode
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                Task {
                    await self?.saveSettings()
                }
            }
            .store(in: &cancellables)

        // 监听置顶状态变化
        $isAlwaysOnTop
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                Task {
                    await self?.saveSettings()
                    WindowService.shared.setAlwaysOnTop(self?.isAlwaysOnTop ?? true)
                }
            }
            .store(in: &cancellables)
    }
}