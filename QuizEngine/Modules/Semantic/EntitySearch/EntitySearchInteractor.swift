//
//  EntitySearchInteractor.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

protocol EntitySearchBusinessLogic: AnyObject {
    func search(query: String)
}

class EntitySearchInteractor: EntitySearchBusinessLogic {
    weak var controller: EntitySearchControllerLogic?
    let service: SemanticServiceProtocol = ServiceFactory.semanticService

    func search(query: String) {
        service.search(query: query) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishSearching(result: response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
