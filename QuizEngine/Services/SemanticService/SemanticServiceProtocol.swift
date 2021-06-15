//
//  SemanticServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import Map

protocol SemanticServiceProtocol {
    func search(query: String, graphType: GraphType, completion: @escaping ([Entity]?, Error?) -> Void)
    func search(region: MapRegion, graphType: GraphType, completion: @escaping ([Entity]?, Error?) -> Void)
    func getQuestions(entityUri: String, graphType: GraphType, completion: @escaping ([Triple]?, Error?) -> Void)
}
