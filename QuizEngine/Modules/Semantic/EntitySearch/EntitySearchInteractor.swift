//
//  EntitySearchInteractor.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

protocol EntitySearchBusinessLogic: AnyObject {
    func loadSomething()
}

class EntitySearchInteractor: EntitySearchBusinessLogic {
    weak var controller: EntitySearchControllerLogic?
    let service: SomeServiceProtocol = SomeServiceFactory.someService

    func loadSomething() {
        service.doRequest() { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishRequest()
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
