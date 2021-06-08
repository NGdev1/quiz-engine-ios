//
//  ParticipantInteractor.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

protocol ParticipantBusinessLogic: AnyObject {
    func loadParticipantResults(quizId: String, participantId: Int)
}

class ParticipantInteractor: ParticipantBusinessLogic {
    weak var controller: ParticipantControllerLogic?
    let service: QuizPassingServiceProtocol = ServiceFactory.quizPassingService

    func loadParticipantResults(quizId: String, participantId: Int) {
        service.userResults(quizId: quizId, userId: participantId) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.presentParticipant(response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
