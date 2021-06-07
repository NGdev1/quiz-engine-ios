//
//  HistoryInteractor.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

protocol HistoryBusinessLogic: AnyObject {
    func loadList()
}

class HistoryInteractor: HistoryBusinessLogic {
    weak var controller: HistoryControllerLogic?
    let service: ProfileServiceProtocol = ServiceFactory.profileService

    func loadList() {
        service.history { [weak self] response, error in
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
