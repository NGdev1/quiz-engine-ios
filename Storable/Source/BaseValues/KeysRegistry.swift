//  Реестра ключей.
//  Для сохранения обратной совместимости могут использоваться легаси константы
//  вместо обратной доменной нотации
final class KeysRegistry {
    /// Токен FCM
    var fcmToken: Storable<String, Storages.Defaults> = "com.md.quiz-engine.key.fcmToken"
    /// Сколько раз пользователь открывал приложение
    var appOpenedCount: Storable<Int, Storages.Defaults> = "com.md.quiz-engine.key.appOpenedCount"
    /// Имя пользователя
    var userName: Storable<String, Storages.Defaults> = "com.md.quiz-engine.key.userName"
    /// Имя пользователя
    var accessToken: Storable<String, Storages.Defaults> = "com.md.quiz-engine.key.accessToken"
    /// URL сервера
    var baseURL: Storable<String, Storages.InMemory> = "com.md.quiz-engine.key.baseURL"
}
