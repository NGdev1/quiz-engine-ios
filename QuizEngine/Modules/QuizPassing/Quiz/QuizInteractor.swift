//
//  QuizInteractor.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

protocol QuizBusinessLogic: AnyObject {
    func loadQuiz(id: String)
}

class QuizInteractor: QuizBusinessLogic {
    weak var controller: QuizControllerLogic?
    let service: QuizServiceProtocol = ServiceFactory.quizService

    func loadQuiz(id: String) {
        service.get(id: id) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.presentQuiz(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
