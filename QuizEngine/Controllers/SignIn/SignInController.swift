//
//  SignInController.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import MDFoundation

protocol SignInControllerLogic: AnyObject {
    func didFinishSignIn(response: Auth.TokenDto)
    func presentError(message: String)
}

public class SignInController: UIViewController, SignInControllerLogic {
    // MARK: - Properties

    var interactor: SignInInteractor?

    lazy var customView: SignInView? = view as? SignInView

    // MARK: - Init

    public init() {
        super.init(
            nibName: Utils.getClassName(SignInView.self),
            bundle: resourcesBundle
        )
        setup()
        setupAppearance()
        addActionHandlers()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        interactor = SignInInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        // title = Text.SignIn.title
    }

    // MARK: - Action handlers

    private func addActionHandlers() {}

    // MARK: - SignInControllerLogic

    func didFinishSignIn(response: Auth.TokenDto) {
        customView?.stopShowingActivityIndicator()
    }

    func presentError(message: String) {
        customView?.stopShowingActivityIndicator()
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
