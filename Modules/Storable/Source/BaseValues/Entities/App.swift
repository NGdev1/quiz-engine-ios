/// Модель текущего пользователя
public final class App {
    /// Реестр ключей
    var keysRegistry: KeysRegistry

    init(keysRegistry: KeysRegistry) {
        self.keysRegistry = keysRegistry
    }

    public var fcmToken: String? {
        get { return keysRegistry.fcmToken.value }
        set { keysRegistry.fcmToken.value = newValue }
    }

    public var appOpenedCount: Int {
        get { return keysRegistry.appOpenedCount.value ?? 0 }
        set { keysRegistry.appOpenedCount.value = newValue }
    }

    public var userName: String? {
        get { return keysRegistry.userName.value }
        set { keysRegistry.userName.value = newValue }
    }

    public var accessToken: String? {
        get { return keysRegistry.accessToken.value }
        set { keysRegistry.accessToken.value = newValue }
    }

    public var baseURL: URL {
        get {
            guard
                let value = keysRegistry.baseURL.value,
                let url = URL(string: value)
            else {
                fatalError("Base URL should at start time of app")
            }
            return url
        }
        set { keysRegistry.baseURL.value = newValue.absoluteString }
    }
}
