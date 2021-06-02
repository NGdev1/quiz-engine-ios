//
//  MainInteractor.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

protocol MainBusinessLogic: AnyObject {
    func loadList()
}

class MainInteractor: MainBusinessLogic {
    weak var controller: MainControllerLogic?
    let service: QuizServiceProtocol = ServiceFactory.quizService

    func loadList() {
        service.getPublicList { [weak self] response, error in
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
