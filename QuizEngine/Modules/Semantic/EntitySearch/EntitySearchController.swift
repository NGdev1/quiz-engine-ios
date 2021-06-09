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
            SelectEntityController(query: query)
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
