//
//  EditQuestionOptionController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

protocol EditQuestionOptionControllerDelegate: AnyObject {}

protocol EditQuestionOptionControllerLogic: AnyObject {
    func presentQuestionOption(_ entity: QuestionOption)
    func presentError(message: String)
}

class EditQuestionOptionController: UIViewController, EditQuestionOptionControllerLogic {
    // MARK: - Properties

    private lazy var customView = EditQuestionOptionView()
    private var interactor: EditQuestionOptionInteractor?

    private let generator = UINotificationFeedbackGenerator()
    private let option: QuestionOption

    weak var delegate: EditQuestionOptionControllerDelegate?

    // MARK: - Init

    init(delegate: EditQuestionOptionControllerDelegate, option: QuestionOption) {
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
        setup()
        setupAppearance()
        addActionHandlers()
    }

    private func setup() {
        interactor = EditQuestionOptionInteractor()
        interactor?.controller = self
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
            title: Text.Common.save, style: .plain,
            target: self, action: #selector(save)
        )
    }

    @objc
    private func save() {
        print(option.text ?? 1)
    }

    // MARK: - Network requests

    // MARK: - EditQuestionOptionControllerLogic

    func presentQuestionOption(_ entity: QuestionOption) {
        customView.updateAppearance(with: entity)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - EditQuestionOptionCellSetupDelegate

extension EditQuestionOptionController: EditQuestionOptionCellSetupDelegate {
    func addQuestion() {}

    func reloadAction() {}
}
