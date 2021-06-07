//
//  EditQuizInteractor.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol EditQuizBusinessLogic: AnyObject {
    func loadItem(id: String)
    func createQuiz(_ quiz: Quiz)
    func updateQuiz(id: String, quiz: Quiz)
}

class EditQuizInteractor: EditQuizBusinessLogic {
    weak var controller: EditQuizControllerLogic?
    let service: QuizServiceProtocol = ServiceFactory.quizService

    func loadItem(id: String) {
        service.getFull(id: id) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishLoadingQuiz(response: response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }

    func createQuiz(_ quiz: Quiz) {
        service.create(quiz: quiz) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishSavingQuiz(response)
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
                self.controller?.didFinishUpdatingQuiz(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
