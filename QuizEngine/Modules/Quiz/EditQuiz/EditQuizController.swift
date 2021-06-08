//
//  EditQuizController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

protocol EditQuizControllerLogic: AnyObject {
    func didFinishSavingQuiz(_ quiz: Quiz)
    func didFinishUpdatingQuiz(_ quiz: Quiz)
    func didFinishLoadingQuiz(response: Quiz)
    func presentError(message: String)
}

class EditQuizController: UIViewController, EditQuizControllerLogic {
    // MARK: - Properties

    private lazy var customView = EditQuizView()
    private var interactor: EditQuizInteractor?

    private let generator = UINotificationFeedbackGenerator()
    private var quiz: Quiz
    private var isQuizLoaded: Bool = false

    // MARK: - Init

    init(quiz: Quiz) {
        self.quiz = quiz
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAppearance()
        addActionHandlers()
    }

    private func setup() {
        interactor = EditQuizInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        if quiz.id == nil {
            navigationItem.title = Text.EditQuiz.createTitle
        } else {
            navigationItem.title = Text.EditQuiz.editTitle
        }
        customView.setDelegate(self)
        if let itemId = quiz.id {
            interactor?.loadItem(id: itemId)
            customView.showLoading()
        } else {
            customView.updateAppearance(with: quiz)
        }
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Text.Common.save, style: .plain,
            target: self, action: #selector(save)
        )
    }

    @objc
    private func save() {
        if validateAndShowError() == false {
            return
        }
        customView.showLoading()
        if let quizId = quiz.id {
            interactor?.updateQuiz(id: quizId, quiz: quiz)
        } else {
            interactor?.createQuiz(quiz)
        }
    }

    // MARK: - EditQuizControllerLogic

    func didFinishLoadingQuiz(response: Quiz) {
        isQuizLoaded = true
        quiz = response
        customView.updateAppearance(with: quiz)
    }

    func didFinishSavingQuiz(_ quiz: Quiz) {
        NotificationCenter.default.post(name: .userChangedQuizList, object: nil)
        NotificationCenter.default.post(name: .userChangedQuiz, object: quiz)
        self.quiz = Quiz()
        customView.updateAppearance(with: self.quiz)
        tabBarController?.selectedIndex = TabBarController.quizListTabIndex
        navigationController?.popViewController()
    }

    func didFinishUpdatingQuiz(_ quiz: Quiz) {
        NotificationCenter.default.post(name: .userChangedQuizList, object: nil)
        NotificationCenter.default.post(name: .userChangedQuiz, object: quiz)
        self.quiz = Quiz()
        customView.updateAppearance(with: self.quiz)
        tabBarController?.selectedIndex = TabBarController.quizListTabIndex
        navigationController?.popViewController()
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }

    // MARK: - Private methods

    private func validateAndShowError() -> Bool {
        if quiz.title == nil || quiz.title?.isEmpty == true {
            if let textField: MDTextField = customView.viewWithTag(EditQuizView.titleTextFieldTag) as? MDTextField {
                textField.shake()
                textField.showError(Text.Errors.fillInTheField)
            }
            return false
        }
        if quiz.description == nil || quiz.description?.isEmpty == true {
            if let textField: MDTextArea = customView.viewWithTag(EditQuizView.descriptionTextAreaTag) as? MDTextArea {
                textField.shake()
                textField.showError(Text.Errors.fillInTheField)
            }
            return false
        }
        return true
    }
}

// MARK: - EditQuizCellSetupDelegate

extension EditQuizController: EditQuizCellSetupDelegate {
    func didSelectQuestion(_ question: Question) {
        customView.endEditing(true)
        navigationController?.pushViewController(
            EditQuestionController(quizId: quiz.id, delegate: self, question: question)
        )
    }

    func addQuestion() {
        customView.endEditing(true)
        navigationController?.pushViewController(
            SelectMethodController(quizId: quiz.id, editQuizController: self)
        )
    }

    func reloadAction() {
        if isQuizLoaded {
            customView.updateAppearance(with: quiz)
            return
        }
        if let itemId = quiz.id {
            interactor?.loadItem(id: itemId)
            customView.showLoading()
        } else {
            customView.updateAppearance(with: quiz)
        }
    }
}

// MARK: - EditQuestionControllerDelegate

extension EditQuizController: EditQuestionControllerDelegate {
    func didFinishEditingQuestion(_ question: Question) {
        if let questionTempId = question.tempId,
           let index = quiz.questions.firstIndex(where: { item in item.tempId == questionTempId })
        {
            quiz.questions[index] = question
        } else {
            quiz.questions.append(question)
        }
        customView.updateAppearance(with: quiz)
    }
}
