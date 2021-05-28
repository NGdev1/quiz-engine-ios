//
//  QuizListInteractor.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol QuizListBusinessLogic: AnyObject {
    func loadList()
}

class QuizListInteractor: QuizListBusinessLogic {
    weak var controller: QuizListControllerLogic?
    let service: QuizServiceProtocol = ServiceFactory.quizService

    func loadList() {
        service.getOwnList { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.displayList(response: response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
