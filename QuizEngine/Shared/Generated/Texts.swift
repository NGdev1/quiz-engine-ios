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

  internal enum Common {
    /// Готово
    internal static let done = Text.tr("Localizable", "Common.Done")
    /// Заполните поля
    internal static let fillInTheFields = Text.tr("Localizable", "Common.FillInTheFields")
    /// Скрыть
    internal static let hide = Text.tr("Localizable", "Common.Hide")
    /// Сохранить
    internal static let save = Text.tr("Localizable", "Common.Save")
  }

  internal enum EditQuestion {
    /// Добавить вариант
    internal static let addOption = Text.tr("Localizable", "EditQuestion.AddOption")
    /// Варианты ответов
    internal static let optionsTitle = Text.tr("Localizable", "EditQuestion.OptionsTitle")
    /// Вопрос
    internal static let textPlaceholder = Text.tr("Localizable", "EditQuestion.TextPlaceholder")
    /// Вопрос
    internal static let title = Text.tr("Localizable", "EditQuestion.Title")
  }

  internal enum EditQuestionOption {
    /// Верный ответ
    internal static let isCorrect = Text.tr("Localizable", "EditQuestionOption.IsCorrect")
    /// Teкст
    internal static let textPlaceholder = Text.tr("Localizable", "EditQuestionOption.TextPlaceholder")
    /// Вариант ответа
    internal static let title = Text.tr("Localizable", "EditQuestionOption.Title")
  }

  internal enum EditQuiz {
    /// Добавить вопрос
    internal static let addQuestion = Text.tr("Localizable", "EditQuiz.AddQuestion")
    /// Новый тест
    internal static let createTitle = Text.tr("Localizable", "EditQuiz.CreateTitle")
    /// Описание
    internal static let descriptionPlaceholder = Text.tr("Localizable", "EditQuiz.DescriptionPlaceholder")
    /// Редактирование
    internal static let editTitle = Text.tr("Localizable", "EditQuiz.EditTitle")
    /// Публичный тест
    internal static let isPublic = Text.tr("Localizable", "EditQuiz.IsPublic")
    /// Название теста
    internal static let namePlaceholder = Text.tr("Localizable", "EditQuiz.NamePlaceholder")
    /// Вопросы
    internal static let questionsHeader = Text.tr("Localizable", "EditQuiz.QuestionsHeader")
    /// Создать
    internal static let tabBarTitle = Text.tr("Localizable", "EditQuiz.TabBarTitle")
  }

  internal enum Errors {
    /// Доступ запрещен
    internal static let authError = Text.tr("Localizable", "Errors.AuthError")
    /// Заполните поле
    internal static let fillInTheField = Text.tr("Localizable", "Errors.FillInTheField")
    /// Ошибка сети
    internal static let networkError = Text.tr("Localizable", "Errors.NetworkError")
    /// Ошибка сервера
    internal static let remoteError = Text.tr("Localizable", "Errors.RemoteError")
    /// Ошибка запроса
    internal static let requestError = Text.tr("Localizable", "Errors.RequestError")
    /// Перезагрузить
    internal static let tryAgain = Text.tr("Localizable", "Errors.TryAgain")
    /// Неизвестная ошибка
    internal static let unknownError = Text.tr("Localizable", "Errors.UnknownError")
  }

  internal enum Main {
    /// Главная
    internal static let title = Text.tr("Localizable", "Main.Title")
  }

  internal enum Onboarding {
    /// Продолжить с Email
    internal static let continueWithEmail = Text.tr("Localizable", "Onboarding.ContinueWithEmail")
    /// Создание и прохождения тестов или викторин.
    internal static let description = Text.tr("Localizable", "Onboarding.Description")
    /// Регистрация
    internal static let registration = Text.tr("Localizable", "Onboarding.Registration")
  }

  internal enum Profile {
    /// Редактировать
    internal static let edit = Text.tr("Localizable", "Profile.Edit")
    /// Выйти
    internal static let logOut = Text.tr("Localizable", "Profile.LogOut")
    /// Профиль
    internal static let title = Text.tr("Localizable", "Profile.Title")
  }

  internal enum Question {
    /// Кол-во вариантов: %d
    internal static func optionsCount(_ p1: Int) -> String {
      return Text.tr("Localizable", "Question.OptionsCount", p1)
    }
  }

  internal enum Quiz {
    /// Тест
    internal static let title = Text.tr("Localizable", "Quiz.Title")
  }

  internal enum QuizList {
    /// Ни одного теста не создано
    internal static let noContent = Text.tr("Localizable", "QuizList.NoContent")
    /// Мои тесты
    internal static let title = Text.tr("Localizable", "QuizList.Title")
  }

  internal enum SignIn {
    /// Email
    internal static let email = Text.tr("Localizable", "SignIn.Email")
    /// Пароль
    internal static let password = Text.tr("Localizable", "SignIn.Password")
    /// Восстановление пароля
    internal static let passwordRecovery = Text.tr("Localizable", "SignIn.PasswordRecovery")
    /// Регистрация
    internal static let registration = Text.tr("Localizable", "SignIn.Registration")
    /// Войти
    internal static let submit = Text.tr("Localizable", "SignIn.Submit")
    /// Вход
    internal static let title = Text.tr("Localizable", "SignIn.Title")
  }

  internal enum SignUp {
    /// Подтверждение пароля
    internal static let confirmPassword = Text.tr("Localizable", "SignUp.ConfirmPassword")
    /// Email
    internal static let email = Text.tr("Localizable", "SignUp.Email")
    /// ФИО
    internal static let fullName = Text.tr("Localizable", "SignUp.FullName")
    /// Пароль
    internal static let password = Text.tr("Localizable", "SignUp.Password")
    /// Пароли не совпадают
    internal static let passwordsNotMatch = Text.tr("Localizable", "SignUp.PasswordsNotMatch")
    /// Зарегистрироваться
    internal static let submit = Text.tr("Localizable", "SignUp.Submit")
    /// Регистрация
    internal static let title = Text.tr("Localizable", "SignUp.Title")
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
