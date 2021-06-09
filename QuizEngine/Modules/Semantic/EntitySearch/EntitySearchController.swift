//
//  EntitySearchController.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import MDFoundation

protocol EntitySearchControllerLogic: AnyObject {
    func didFinishSearching(result: [Entity])
    func presentError(message: String)
}

class EntitySearchController: UIViewController, EntitySearchControllerLogic {
    // MARK: - Properties

    var interactor: EntitySearchInteractor?

    lazy var customView = EntitySearchView()

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
        interactor = EntitySearchInteractor()
        interactor?.controller = self
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
        customView.startShowingActivityIndicator(needToDimBackground: true)
        interactor?.search(query: query)
    }

    // MARK: - EntitySearchControllerLogic

    func didFinishSearching(result: [Entity]) {
        customView.stopShowingActivityIndicator()
    }

    func presentError(message: String) {
        customView.stopShowingActivityIndicator()
        guard message != .empty else { return }
        let alert = AlertsFactory.plain(
            title: Text.Alert.error,
            message: message,
            tintColor: Assets.baseTint1.color,
            cancelText: Text.Alert.cancel
        )
        present(alert, animated: true, completion: nil)
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
