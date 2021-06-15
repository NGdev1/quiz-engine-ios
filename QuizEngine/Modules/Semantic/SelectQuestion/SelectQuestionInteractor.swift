//
//  SelectQuestionInteractor.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

protocol SelectQuestionBusinessLogic: AnyObject {
    func getSuitableTriples(for entity: Entity, graphType: GraphType)
}

class SelectQuestionInteractor: SelectQuestionBusinessLogic {
    weak var controller: SelectQuestionControllerLogic?
    let service: SemanticServiceProtocol = ServiceFactory.semanticService

    func getSuitableTriples(for entity: Entity, graphType: GraphType) {
        service.getQuestions(entityUri: entity.uri, graphType: graphType) { [weak self] response, error in
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
