//
//  QuizResultInteractor.swift
//  QuizEngine
//
//  Created by Admin on 06.06.2021.
//

protocol QuizResultBusinessLogic: AnyObject {
    func get(quizId: String, passingId: Int)
}

class QuizResultInteractor: QuizResultBusinessLogic {
    weak var controller: QuizResultControllerLogic?
    let service: QuizPassingServiceProtocol = ServiceFactory.quizPassingService

    func get(quizId: String, passingId: Int) {
        service.get(quizId: quizId, passingId: passingId) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.presentQuizResults(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
