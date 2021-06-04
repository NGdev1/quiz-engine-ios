//
//  QuestionInteractor.swift
//  QuizEngine
//
//  Created by Admin on 05.06.2021.
//

protocol QuestionBusinessLogic: AnyObject {
    func giveAnswer(quizId: String, passingId: Int, answer: QuestionAnswer)
}

class QuestionInteractor: QuestionBusinessLogic {
    weak var controller: QuestionControllerLogic?
    let service: QuizPassingServiceProtocol = ServiceFactory.quizPassingService

    func giveAnswer(quizId: String, passingId: Int, answer: QuestionAnswer) {
        service.giveAnswer(quizId: quizId, passingId: passingId, answer: answer) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishAnswering(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
