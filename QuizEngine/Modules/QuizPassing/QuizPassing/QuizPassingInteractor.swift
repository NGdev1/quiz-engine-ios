//
//  QuizPassingInteractor.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

protocol QuizPassingBusinessLogic: AnyObject {
    func createPassing(quizId: String)
}

class QuizPassingInteractor: QuizPassingBusinessLogic {
    weak var controller: QuizPassingControllerLogic?
    let service: QuizPassingServiceProtocol = ServiceFactory.quizPassingService

    func createPassing(quizId: String) {
        service.create(quizId: quizId) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishCreatingPassing(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
