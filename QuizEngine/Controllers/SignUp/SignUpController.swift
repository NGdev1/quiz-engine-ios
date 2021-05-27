//
//  SignUpController.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import MDFoundation

protocol SignUpControllerLogic: AnyObject {
    func didFinishSignUp(response: Auth.TokenDto)
    func presentError(message: String)
}

class SignUpController: UIViewController, SignUpControllerLogic {
    // MARK: - Properties

    var interactor: SignUpInteractor?

    lazy var customView: SignUpView? = view as? SignUpView

    override var canBecomeFirstResponder: Bool { true }
    override var inputAccessoryView: UIView? { customView?.bottomView }

    // MARK: - Init

    init() {
        super.init(
            nibName: Utils.getClassName(SignUpView.self),
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
        interactor = SignUpInteractor()
        interactor?.controller = self
    }

    private func setupAppearance() {
        title = Text.SignUp.title
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        customView?.bottomView.actionButton.addTarget(
            self, action: #selector(signUp), for: .touchUpInside
        )
        customView?.signUpAction = { [weak self] in
            self?.signUp()
        }
    }

    @objc
    private func signUp() {
        customView?.startShowingLoading()
    }

    // MARK: - SignUpControllerLogic

    func didFinishSignUp(response: Auth.TokenDto) {
        customView?.stopShowingLoading()
    }

    func presentError(message: String) {
        customView?.stopShowingLoading()
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
