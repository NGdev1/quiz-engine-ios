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

    private lazy var customView = QuizPassingView()
    private var interactor: QuizPassingInteractor?

    private let generator = UINotificationFeedbackGenerator()
    private let quizId: String
    private var quizPassing: QuizPassing?
    private var questionController: QuestionController?

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

    private func initQuestionController() {
        guard let passingId = quizPassing?.id else { return }
        questionController = QuestionController(quizId: quizId, passingId: passingId)
        questionController?.delegate = self
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
        initQuestionController()
    }

    func presentError(message: String) {
        generator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - QuizPassingCellSetupDelegate

extension QuizPassingController: QuizPassingCellSetupDelegate {
    func didSelectQuestion(_ question: Question, answer: QuestionAnswer?) {
        guard let questionController = questionController else { return }
        questionController.showQuestion(question, answer: answer)
        navigationController?.pushViewController(questionController)
    }

    func reloadAction() {
        loadQuiz()
    }
}

// MARK: - QuestionControllerDelegate

extension QuizPassingController: QuestionControllerDelegate {
    func didFinishAnswering(question: Question, answer: QuestionAnswer) {
        guard
            let quizPassing = quizPassing,
            let lastQuestionId: Int = question.id,
            let lastIndex: Int = quizPassing.questions.firstIndex(where: { item in
                item.id == lastQuestionId
            }) else { return }
        if let answerIndex = quizPassing.answers.firstIndex(where: { item in
            item.question?.id == lastQuestionId
        }) {
            quizPassing.answers[answerIndex] = answer
        } else {
            quizPassing.answers.append(answer)
        }
        customView.updateAppearance(with: quizPassing)
        let questionsCount: Int = quizPassing.questions.count
        if lastIndex < questionsCount - 1 {
            let nextQuestion: Question = quizPassing.questions[lastIndex + 1]
            let nextAnswer: QuestionAnswer? = quizPassing.answers.first(where: { item in
                guard nextQuestion.id != nil else { return false }
                return item.question?.id == nextQuestion.id
            })
            questionController?.showQuestion(nextQuestion, answer: nextAnswer)
        } else {
            navigationController?.popViewController()
        }
    }
}
