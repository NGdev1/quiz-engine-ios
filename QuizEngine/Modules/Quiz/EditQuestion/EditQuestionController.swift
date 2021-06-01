//
//  EditQuestionController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

protocol EditQuestionControllerDelegate: AnyObject {
    func didFinishEditingQuestion(_ question: Question)
}

protocol EditQuestionControllerLogic: AnyObject {
    func didFinishSavingQuestion(_ question: Question)
    func didFinishUpdatingQuestion(_ question: Question)
    func presentError(message: String)
}

class EditQuestionController: UIViewController, EditQuestionControllerLogic {
    // MARK: - Properties

    private lazy var customView = EditQuestionView()
    private var interactor: EditQuestionInteractor?

    private let generator = UINotificationFeedbackGenerator()
    private let quizId: String?
    private let question: Question

    weak var delegate: EditQuestionControllerDelegate?

    // MARK: - Init

    init(quizId: String?, delegate: EditQuestionControllerDelegate, question: Question) {
        self.quizId = quizId
        self.delegate = delegate
        self.question = question
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
        interactor = EditQuestionInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.EditQuestion.title
        customView.setDelegate(self)
        customView.updateAppearance(with: question)
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
        if let quizId = quizId {
            customView.showLoading()
            if let questionId = question.id {
                interactor?.updateQuestion(quizId: quizId, questionId: questionId, question: question)
            } else {
                interactor?.createQuestion(quizId: quizId, question: question)
            }
            return
        } else {
            delegate?.didFinishEditingQuestion(question)
            navigationController?.popViewController()
            return
        }
    }

    // MARK: - EditQuestionControllerLogic

    func didFinishSavingQuestion(_ question: Question) {
        delegate?.didFinishEditingQuestion(question)
        navigationController?.popViewController()
    }

    func didFinishUpdatingQuestion(_ question: Question) {
        delegate?.didFinishEditingQuestion(question)
        navigationController?.popViewController()
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.updateAppearance(with: question)
        guard message != .empty else { return }
        let alert = AlertsFactory.plain(
            title: Text.Alert.error,
            message: message,
            tintColor: Assets.baseTint1.color,
            cancelText: Text.Alert.cancel
        )
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Private methods

    private func validateAndShowError() -> Bool {
        if question.text == nil || question.text?.isEmpty == true {
            if let textField: MDTextField = customView.viewWithTag(EditQuestionView.textTag) as? MDTextField {
                textField.shake()
                textField.showError(Text.Errors.fillInTheField)
            }
            return false
        }
        return true
    }
}

// MARK: - EditQuestionCellSetupDelegate

extension EditQuestionController: EditQuestionCellSetupDelegate {
    func didSelectOption(_ option: QuestionOption) {
        customView.endEditing(true)
        navigationController?.pushViewController(
            EditQuestionOptionController(questionId: question.id, delegate: self, option: option)
        )
    }

    func addOption() {
        customView.endEditing(true)
        navigationController?.pushViewController(
            EditQuestionOptionController(questionId: question.id, delegate: self, option: QuestionOption(id: nil))
        )
    }

    func reloadAction() {
        customView.updateAppearance(with: question)
    }
}

// MARK: - EditQuestionCellSetupDelegate

extension EditQuestionController: EditQuestionOptionControllerDelegate {
    func didFinishEditingOption(_ option: QuestionOption) {
        if let optionId = option.id,
           let index = question.options?.firstIndex(where: { item in item.id == optionId })
        {
            question.options?[index] = option
        } else {
            question.options?.append(option)
        }
        customView.updateAppearance(with: question)
    }
}
