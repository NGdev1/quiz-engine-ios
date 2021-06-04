//
//  QuestionController.swift
//  QuizEngine
//
//  Created by Admin on 05.06.2021.
//

import MDFoundation

protocol QuestionControllerDelegate: AnyObject {
    func didFinishAnswering(question: Question, answer: QuestionAnswer)
}

protocol QuestionControllerLogic: AnyObject {
    func didFinishAnswering(_ answer: QuestionAnswer)
    func presentError(message: String)
}

class QuestionController: UIViewController, QuestionControllerLogic {
    // MARK: - Properties

    private var interactor: QuestionInteractor?
    private lazy var customView = QuestionView()
    private lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    private let quizId: String
    private let passingId: Int
    private var question: Question?

    weak var delegate: QuestionControllerDelegate?

    override var canBecomeFirstResponder: Bool { true }
    override var inputAccessoryView: UIView? { customView.bottomView }

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
        addActionHandlers()
    }

    private func setup() {
        interactor = QuestionInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        title = Text.Question.title
        extendedLayoutIncludesOpaqueBars = true
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView.setDelegate(self)
        customView.bottomView.actionButton.addTarget(
            self, action: #selector(answerQuestion), for: .touchUpInside
        )
    }

    @objc
    private func answerQuestion() {
        guard let question = question, let selectedOption = customView.getSelectedOption() else { return }
        let answer = QuestionAnswer(question: question, option: selectedOption)
        customView.showLoading()
        interactor?.giveAnswer(quizId: quizId, passingId: passingId, answer: answer)
    }

    // MARK: - Internal methods

    func showQuestion(_ question: Question, answer: QuestionAnswer?) {
        self.question = question
        customView.showQuestion(question, answer: answer)
    }

    // MARK: - QuestionControllerLogic

    func didFinishAnswering(_ answer: QuestionAnswer) {
        guard let question = question else { return }
        delegate?.didFinishAnswering(question: question, answer: answer)
    }

    func presentError(message: String) {
        customView.endRefreshing()
        notificationFeedbackGenerator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - QuestionsDataSourceDelegate

extension QuestionController: QuestionOptionsDataSourceDelegate {
    func actionButtonTapped() {
        customView.showLoading()
    }
}
