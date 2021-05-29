//
//  EditQuizController.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

protocol EditQuizControllerLogic: AnyObject {
    func presentQuiz(_ entity: Quiz)
    func presentError(message: String)
}

class EditQuizController: UIViewController, EditQuizControllerLogic {
    // MARK: - Properties

    private lazy var customView = EditQuizView()
    private var interactor: EditQuizInteractor?

    private let generator = UINotificationFeedbackGenerator()
    private let quiz: Quiz

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
        customView.updateAppearance(with: quiz)
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
        print(quiz.title ?? 1)
    }

    // MARK: - Network requests

    // MARK: - EditQuizControllerLogic

    func presentQuiz(_ entity: Quiz) {
        customView.updateAppearance(with: entity)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - EditQuizCellSetupDelegate

extension EditQuizController: EditQuizCellSetupDelegate {
    func reloadAction() {}
}
