//
//  PublicQuizController.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

import MDFoundation

protocol PublicQuizControllerLogic: AnyObject {
    func presentQuiz(_ entity: Quiz)
    func presentError(message: String)
}

class PublicQuizController: UIViewController, PublicQuizControllerLogic {
    // MARK: - Properties

    lazy var customView = PublicQuizView()
    var interactor: PublicQuizInteractor?

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
        addActionHandlers()
    }

    private func setup() {
        interactor = PublicQuizInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.Quiz.title
        customView.setDelegate(self)
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(userPassedQuiz(notification:)),
            name: .userFinishedQuiz, object: nil
        )
    }

    @objc
    private func userPassedQuiz(notification: NSNotification) {
        guard
            let quizPassing = notification.object as? QuizPassing,
            quizPassing.quiz?.id == id
        else { return }
        loadQuiz()
    }

    // MARK: - Network requests

    private func loadQuiz() {
        customView.showLoading(entity: quiz)
        interactor?.loadQuiz(id: id)
    }

    // MARK: - PublicQuizControllerLogic

    func presentQuiz(_ entity: Quiz) {
        customView.updateAppearance(with: entity)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - PublicQuizCellSetupDelegate

extension PublicQuizController: PublicQuizCellSetupDelegate {
    func startQuiz() {
        let quizPassingController = QuizPassingController(quizId: id)
        let navigationController = UINavigationController(rootViewController: quizPassingController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    func reloadAction() {
        loadQuiz()
    }
}
