//
//  EditQuestionOptionInteractor.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol EditQuestionOptionBusinessLogic: AnyObject {
    func createOption(questionId: Int, option: QuestionOption)
    func updateOption(questionId: Int, optionId: Int, option: QuestionOption)
}

class EditQuestionOptionInteractor: EditQuestionOptionBusinessLogic {
    weak var controller: EditQuestionOptionControllerLogic?
    let service: QuestionOptionServiceProtocol = ServiceFactory.optionsService

    func createOption(questionId: Int, option: QuestionOption) {
        service.create(questionId: questionId, option: option) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.presentQuestionOption(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }

    func updateOption(questionId: Int, optionId: Int, option: QuestionOption) {
        service.update(questionId: questionId, optionId: optionId, option: option) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.presentQuestionOption(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
