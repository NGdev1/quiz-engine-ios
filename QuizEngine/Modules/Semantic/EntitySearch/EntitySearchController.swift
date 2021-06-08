//
//  EntitySearchController.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import MDFoundation

protocol EntitySearchControllerLogic: AnyObject {
    func didFinishRequest()
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
        // title = Text.EntitySearch.title
    }

    // MARK: - Action handlers

    private func addActionHandlers() {}

    // MARK: - EntitySearchControllerLogic

    func didFinishRequest() {
        customView.stopShowingActivityIndicator()
        // customView.display(viewModel: viewModel)
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
