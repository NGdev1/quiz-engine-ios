//
//  SelectQuestionController.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import MDFoundation

protocol SelectQuestionControllerLogic: AnyObject {
    func displayList(response: [Triple])
    func presentError(message: String)
}

class SelectQuestionController: UIViewController, SelectQuestionControllerLogic {
    // MARK: - Properties

    var interactor: SelectQuestionInteractor?

    lazy var customView = SelectQuestionView()
    lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    let entity: Entity
    let quizId: String?
    let editQuizController: EditQuestionControllerDelegate
    let graphType: GraphType

    // MARK: - Init

    init(entity: Entity,
         quizId: String?,
         editQuizController: EditQuestionControllerDelegate,
         graphType: GraphType)
    {
        self.entity = entity
        self.quizId = quizId
        self.editQuizController = editQuizController
        self.graphType = graphType
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
        loadTriples()
    }

    private func setup() {
        interactor = SelectQuestionInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        title = Text.SelectQuestion.title
        extendedLayoutIncludesOpaqueBars = true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Network requests

    @objc
    private func loadTriples() {
        interactor?.getSuitableTriples(for: entity, graphType: graphType)
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView.refreshControl?.addTarget(
            self,
            action: #selector(loadTriples),
            for: .valueChanged
        )
        customView.setDelegate(self)
    }

    // MARK: - SelectQuestionControllerLogic

    func displayList(response: [Triple]) {
        customView.updateTriples(response)
    }

    func presentError(message: String) {
        notificationFeedbackGenerator.notificationOccurred(.error)
        customView.showError(message: message)
    }
}

// MARK: - TriplesDataSourceDelegate

extension SelectQuestionController: TriplesDataSourceDelegate {
    func didSelectTriple(_ item: Triple) {
        let question = Question()
        question.text = Text.SelectQuestion.questionText(item.predicate.label, item.subject.label)
        let option = QuestionOption()
        option.text = item.object.label
        option.isCorrect = true
        question.options = [option]
        navigationController?.pushViewController(
            EditQuestionController(quizId: quizId, delegate: editQuizController, question: question)
        )
    }

    func actionButtonTapped() {
        customView.showLoading()
        loadTriples()
    }
}
