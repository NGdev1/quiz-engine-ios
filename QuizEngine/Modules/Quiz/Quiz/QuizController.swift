//
//  QuizController.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

import MDFoundation

protocol QuizControllerLogic: AnyObject {
    func presentQuiz(_ entity: Quiz)
    func presentError(message: String)
}

class QuizController: UIViewController, QuizControllerLogic {
    // MARK: - Properties

    lazy var customView = QuizView()
    var interactor: QuizInteractor?

    let generator = UINotificationFeedbackGenerator()
    let id: String
    let quiz: Quiz

    // MARK: - Init

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    init(id: String, quiz: Quiz) {
        self.id = id
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
        loadQuiz()
    }

    private func setup() {
        interactor = QuizInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.Quiz.title
        customView.setDelegate(self)
    }

    // MARK: - Network requests

    private func loadQuiz() {
        customView.showLoading()
        interactor?.loadQuiz(id: id)
    }

    // MARK: - QuizControllerLogic

    func presentQuiz(_ entity: Quiz) {
        customView.updateAppearance(with: entity)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - QuizCellSetupDelegate

extension QuizController: QuizCellSetupDelegate {
    func showAllAttemptsOf(user: Profile) {}

    func editQuiz() {
        navigationController?.pushViewController(EditQuizController(quiz: quiz))
    }

    func reloadAction() {
        loadQuiz()
    }
}
