//
//  SignUpInteractor.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

protocol SignUpBusinessLogic: AnyObject {
    func signUp(form: Auth.SignUpForm)
}

class SignUpInteractor: SignUpBusinessLogic {
    weak var controller: SignUpControllerLogic?
    let service: AuthServiceProtocol = ServiceFactory.authService

    func signUp(form: Auth.SignUpForm) {
        service.signUp(form) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
            }
            if let response = response {
                self.controller?.didFinishSignUp(response: response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
