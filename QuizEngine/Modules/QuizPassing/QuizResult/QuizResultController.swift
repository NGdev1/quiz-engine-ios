//
//  QuizResultController.swift
//  QuizEngine
//
//  Created by Admin on 06.06.2021.
//

import MDFoundation

protocol QuizResultControllerLogic: AnyObject {
    func presentQuizResults(_ entity: QuizPassing)
    func presentError(message: String)
}

class QuizResultController: UIViewController, QuizResultControllerLogic {
    // MARK: - Properties

    lazy var customView = QuizResultView()
    var interactor: QuizResultInteractor?

    let generator = UINotificationFeedbackGenerator()
    let quizId: String
    let passingId: Int

    // MARK: - Init

    init(quizId: String, passingId: Int) {
        self.quizId = quizId
        self.passingId = passingId
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
        loadQuizPassing()
    }

    private func setup() {
        interactor = QuizResultInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.QuizPassing.title
        customView.setDelegate(self)
    }

    // MARK: - Network requests

    private func loadQuizPassing() {
        customView.showLoading()
        interactor?.get(quizId: quizId, passingId: passingId)
    }

    // MARK: - QuizResultControllerLogic

    func presentQuizResults(_ entity: QuizPassing) {
        customView.updateAppearance(with: entity)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - QuizResultCellSetupDelegate

extension QuizResultController: QuizResultCellSetupDelegate {
    func reloadAction() {
        loadQuizPassing()
    }
}
