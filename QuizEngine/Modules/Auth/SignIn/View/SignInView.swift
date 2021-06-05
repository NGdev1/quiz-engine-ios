//
//  SignInView.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import MDFoundation

final class SignInView: UIView {
    // MARK: - Properties

    lazy var bottomView: FixedBottomView = FixedBottomView(buttonText: Text.SignIn.submit)

    @IBOutlet var emailTextField: MDTextField!
    @IBOutlet var passwordTextField: MDTextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var restorePasswordButton: UIButton!

    var signInAction: (() -> Void)?

    // MARK: - Xib Init

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        addActionHandlers()
    }

    // MARK: - Private methods

    private func commonInit() {
        setupStyle()
    }

    private func setupStyle() {
        emailTextField.delegate = self
        emailTextField.placeholder = Text.SignIn.email
        emailTextField.isFloatingPlaceholder = true
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        passwordTextField.delegate = self
        passwordTextField.placeholder = Text.SignIn.password
        passwordTextField.isFloatingPlaceholder = true
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        signUpButton.setTitle(Text.SignIn.registration, for: .normal)
        restorePasswordButton.setTitle(Text.SignIn.passwordRecovery, for: .normal)
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        let dismissTapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboardAction)
        )
        addGestureRecognizer(dismissTapRecognizer)
    }

    @objc func dismissKeyboardAction() {
        endEditing(true)
    }

    // MARK: - Internal methods

    func startShowingLoading() {
        endEditing(true)
        startShowingActivityIndicator(needToDimBackground: true)
        bottomView.actionButton.isEnabled = false
    }

    func stopShowingLoading() {
        stopShowingActivityIndicator()
        bottomView.actionButton.isEnabled = true
    }
}

// MARK: - MDTextFieldDelegate

extension SignInView: MDTextFieldDelegate {
    func textFieldShouldReturn(_ textField: MDTextField) -> Bool {
        if textField == emailTextField {
            _ = passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            signInAction?()
        }
        return true
    }

    func textDidChange(_ textField: MDTextField, text: String?) {}
}
