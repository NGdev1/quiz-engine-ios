//
//  SelectMethodController.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import MDFoundation

class SelectMethodController: UIViewController {
    // MARK: - Properties

    lazy var customView = SelectMethodView()
    lazy var selectionFeedbackGenerator = UISelectionFeedbackGenerator()

    let quizId: String?
    let editQuizController: EditQuestionControllerDelegate

    // MARK: - Init

    init(quizId: String?, editQuizController: EditQuestionControllerDelegate) {
        self.quizId = quizId
        self.editQuizController = editQuizController
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
    }

    private func setupAppearance() {
        title = Text.SelectMethod.title
        extendedLayoutIncludesOpaqueBars = true
        customView.setDelegate(self)
    }
}

// MARK: - QuestionCreatingMethodsDataSourceDelegate

extension SelectMethodController: QuestionCreatingMethodsDataSourceDelegate {
    func didSelectQuestionCreatingMethod(_ item: QuestionCreatingMethod) {
        selectionFeedbackGenerator.selectionChanged()
        switch item {
        case .bySearch:
            navigationController?.pushViewController(
                EntitySearchController(quizId: quizId, editQuizController: editQuizController)
            )
        case .byMap:
            navigationController?.pushViewController(
                SelectRegionController(quizId: quizId, editQuizController: editQuizController)
            )
        case .manually:
            navigationController?.pushViewController(
                EditQuestionController(quizId: quizId, delegate: editQuizController, question: Question())
            )
        }
    }
}
