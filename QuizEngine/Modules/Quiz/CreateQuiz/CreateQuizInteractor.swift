//
//  CreateQuizInteractor.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol CreateQuizBusinessLogic: AnyObject {
    func createQuiz(_ quiz: Quiz)
    func updateQuiz(id: String, quiz: Quiz)
}

class CreateQuizInteractor: CreateQuizBusinessLogic {
    weak var controller: CreateQuizControllerLogic?
    let service: QuizServiceProtocol = ServiceFactory.quizService

    func createQuiz(_ quiz: Quiz) {
        service.create(quiz: quiz) { [weak self] response, error in
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

    func updateQuiz(id: String, quiz: Quiz) {
        service.update(id: id, quiz: quiz) { [weak self] response, error in
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
