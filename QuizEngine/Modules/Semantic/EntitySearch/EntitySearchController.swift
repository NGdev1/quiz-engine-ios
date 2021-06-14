//
//  EntitySearchController.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import MDFoundation

class EntitySearchController: UIViewController {
    // MARK: - Properties

    lazy var customView = EntitySearchView()

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
        addActionHandlers()
    }

    private func setupAppearance() {
        title = Text.EntitySearch.title
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView.queryTextField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Text.EntitySearch.search, style: .plain,
            target: self, action: #selector(searchAction)
        )
    }

    @objc
    private func searchAction() {
        guard let query = customView.queryTextField.text, query.isEmpty == false else {
            customView.queryTextField.showError(Text.Errors.fillInTheField)
            customView.queryTextField.shake()
            return
        }
        customView.endEditing(true)
        navigationController?.pushViewController(
            SelectEntityController(
                method: .query(text: query), quizId: quizId,
                editQuizController: editQuizController
            )
        )
    }
}

// MARK: -

extension EntitySearchController: MDTextFieldDelegate {
    func textDidChange(_ textField: MDTextField, text: String?) {}

    func textFieldShouldReturn(_ textField: MDTextField) -> Bool {
        searchAction()
        return true
    }
}
