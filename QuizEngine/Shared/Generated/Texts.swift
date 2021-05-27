// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Text {

  internal enum Alert {
    /// Отмена
    internal static let cancel = Text.tr("Localizable", "Alert.Cancel")
    /// Ошибка
    internal static let error = Text.tr("Localizable", "Alert.Error")
  }

  internal enum Errors {
    /// Ошибка запроса
    internal static let requestError = Text.tr("Localizable", "Errors.RequestError")
  }

  internal enum Onboarding {
    /// Продолжить с Email
    internal static let continueWithEmail = Text.tr("Localizable", "Onboarding.ContinueWithEmail")
    /// Создание и прохождения тестов или викторин.
    internal static let description = Text.tr("Localizable", "Onboarding.Description")
    /// Регистрация
    internal static let registration = Text.tr("Localizable", "Onboarding.Registration")
  }

  internal enum SignIn {
    /// Войти
    internal static let submit = Text.tr("Localizable", "SignIn.Submit")
    /// Вход
    internal static let title = Text.tr("Localizable", "SignIn.Title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Text {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = resourcesBundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
