//
//  ProfileInteractor.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol ProfileBusinessLogic: AnyObject {
    func loadProfile()
}

class ProfileInteractor: ProfileBusinessLogic {
    weak var controller: ProfileControllerLogic?
    let service: ProfileServiceProtocol = ServiceFactory.profileService

    func loadProfile() {
        service.get { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
            }
            if let response = response {
                self.controller?.presentProfile(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
