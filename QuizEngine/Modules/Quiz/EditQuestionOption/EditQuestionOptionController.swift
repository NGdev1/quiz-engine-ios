//
//  EditQuestionOptionController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

protocol EditQuestionOptionControllerDelegate: AnyObject {
    func didFinishEditingOption(_ option: QuestionOption)
}

class EditQuestionOptionController: UIViewController {
    // MARK: - Properties

    private lazy var customView = EditQuestionOptionView()

    private let generator = UINotificationFeedbackGenerator()
    private let questionId: Int?
    private let option: QuestionOption

    weak var delegate: EditQuestionOptionControllerDelegate?

    // MARK: - Init

    init(questionId: Int?, delegate: EditQuestionOptionControllerDelegate, option: QuestionOption) {
        self.questionId = questionId
        self.delegate = delegate
        self.option = option
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
        title = Text.EditQuestionOption.title
        customView.setDelegate(self)
        customView.updateAppearance(with: option)
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
        delegate?.didFinishEditingOption(option)
        navigationController?.popViewController()
    }

    // MARK: - Private methods

    private func validateAndShowError() -> Bool {
        if option.text == nil || option.text?.isEmpty == true {
            if let textField: MDTextField = customView.viewWithTag(EditQuestionOptionView.textTag) as? MDTextField {
                textField.shake()
                textField.showError(Text.Errors.fillInTheField)
            }
            return false
        }
        return true
    }
}

// MARK: - EditQuestionOptionCellSetupDelegate

extension EditQuestionOptionController: EditQuestionOptionCellSetupDelegate {
    func reloadAction() {
        customView.updateAppearance(with: option)
    }
}
