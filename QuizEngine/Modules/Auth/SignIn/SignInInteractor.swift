//
//  SignInInteractor.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

protocol SignInBusinessLogic: AnyObject {
    func signIn(form: Auth.SignInForm)
}

class SignInInteractor: SignInBusinessLogic {
    weak var controller: SignInControllerLogic?
    let service: AuthServiceProtocol = ServiceFactory.authService

    func signIn(form: Auth.SignInForm) {
        service.signIn(form) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
            }
            if let response = response {
                self.controller?.didFinishSignIn(response: response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
