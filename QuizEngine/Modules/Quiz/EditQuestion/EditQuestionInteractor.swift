//
//  EditQuestionInteractor.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol EditQuestionBusinessLogic: AnyObject {
    func createQuestion(quizId: String, question: Question)
    func updateQuestion(quizId: String, questionId: Int, question: Question)
}

class EditQuestionInteractor: EditQuestionBusinessLogic {
    weak var controller: EditQuestionControllerLogic?
    let service: QuestionServiceProtocol = ServiceFactory.questionService

    func createQuestion(quizId: String, question: Question) {
        service.create(quizId: quizId, question: question) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishSavingQuestion(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }

    func updateQuestion(quizId: String, questionId: Int, question: Question) {
        service.update(quizId: quizId, questionId: questionId, question: question) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishUpdatingQuestion(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
