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

class EditQuestionController: UIViewController {
    // MARK: - Properties

    private lazy var customView = EditQuestionView()

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
        setupAppearance()
        addActionHandlers()
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
            title: Text.Common.done, style: .plain,
            target: self, action: #selector(save)
        )
    }

    @objc
    private func save() {
        if validateAndShowError() == false {
            return
        }
        delegate?.didFinishEditingQuestion(question)
        navigationController?.popViewController()
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
            EditQuestionOptionController(questionId: question.id, delegate: self, option: QuestionOption())
        )
    }

    func reloadAction() {
        customView.updateAppearance(with: question)
    }
}

// MARK: - EditQuestionCellSetupDelegate

extension EditQuestionController: EditQuestionOptionControllerDelegate {
    func didFinishEditingOption(_ option: QuestionOption) {
        if let optionTempId = option.tempId,
           let index = question.options.firstIndex(where: { item in item.tempId == optionTempId })
        {
            question.options[index] = option
        } else {
            question.options.append(option)
        }
        customView.updateAppearance(with: question)
    }
}
