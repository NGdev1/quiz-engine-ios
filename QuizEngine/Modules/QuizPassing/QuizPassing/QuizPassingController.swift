//
//  QuizPassingController.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

import MDFoundation

protocol QuizPassingControllerLogic: AnyObject {
    func didFinishCreatingPassing(_ quizPassing: QuizPassing)
    func presentError(message: String)
}

class QuizPassingController: UIViewController, QuizPassingControllerLogic {
    // MARK: - Properties

    lazy var customView = QuizPassingView()
    var interactor: QuizPassingInteractor?

    let generator = UINotificationFeedbackGenerator()
    let quizId: String
    var quizPassing: QuizPassing?

    // MARK: - Init

    init(quizId: String) {
        self.quizId = quizId
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
        interactor = QuizPassingInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        extendedLayoutIncludesOpaqueBars = true
        title = Text.QuizPassing.title
        customView.setDelegate(self)
    }

    // MARK: - Network requests

    private func loadQuiz() {
        customView.showLoading()
        interactor?.createPassing(quizId: quizId)
    }

    // MARK: - QuizPassingControllerLogic

    func didFinishCreatingPassing(_ quizPassing: QuizPassing) {
        self.quizPassing = quizPassing
        customView.updateAppearance(with: quizPassing)
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - QuizPassingCellSetupDelegate

extension QuizPassingController: QuizPassingCellSetupDelegate {
    func reloadAction() {
        loadQuiz()
    }
}
