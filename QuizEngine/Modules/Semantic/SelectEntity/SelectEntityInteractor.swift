//
//  SelectEntityInteractor.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import Map

protocol SelectEntityBusinessLogic: AnyObject {
    func search(query: String)
    func search(region: MapRegion)
}

class SelectEntityInteractor: SelectEntityBusinessLogic {
    weak var controller: SelectEntityControllerLogic?
    let service: SemanticServiceProtocol = ServiceFactory.semanticService

    func search(query: String) {
        service.search(query: query, graphType: .wikidata) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishSearching(result: response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }

    func search(region: MapRegion) {
        service.search(region: region, graphType: .dbpedia) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.controller?.presentError(message: error.localizedDescription)
                return
            }
            if let response = response {
                self.controller?.didFinishSearching(result: response)
            } else {
                self.controller?.presentError(message: Text.Errors.requestError)
            }
        }
    }
}
