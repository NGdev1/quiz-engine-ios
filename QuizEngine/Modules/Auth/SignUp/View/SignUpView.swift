//
//  SignUpView.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import MDFoundation

final class SignUpView: UIView {
    // MARK: - Properties

    lazy var bottomView: FixedBottomView = FixedBottomView(buttonText: Text.SignUp.submit)

    @IBOutlet var fullNameTextField: MDTextField!
    @IBOutlet var emailTextField: MDTextField!
    @IBOutlet var passwordTextField: MDTextField!
    @IBOutlet var confirmPasswordTextField: MDTextField!

    var signUpAction: (() -> Void)?

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
        fullNameTextField.delegate = self
        fullNameTextField.placeholder = Text.SignUp.fullName
        fullNameTextField.isFloatingPlaceholder = true
        fullNameTextField.textContentType = .givenName
        fullNameTextField.keyboardType = .default
        fullNameTextField.autocapitalizationType = .words

        emailTextField.delegate = self
        emailTextField.placeholder = Text.SignUp.email
        emailTextField.isFloatingPlaceholder = true
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none

        passwordTextField.delegate = self
        passwordTextField.placeholder = Text.SignUp.password
        passwordTextField.isFloatingPlaceholder = true
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none

        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.placeholder = Text.SignUp.confirmPassword
        confirmPasswordTextField.isFloatingPlaceholder = true
        confirmPasswordTextField.textContentType = .password
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.autocapitalizationType = .none
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

// MARK: - UITextFieldDelegate

extension SignUpView: MDTextFieldDelegate {
    func textFieldShouldReturn(_ textField: MDTextField) -> Bool {
        if textField == fullNameTextField {
            _ = emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            _ = passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            _ = confirmPasswordTextField.becomeFirstResponder()
        } else {
            signUpAction?()
        }
        return true
    }

    func textDidChange(_ textField: MDTextField, text: String?) {}
}
