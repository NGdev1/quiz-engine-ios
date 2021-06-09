//
//  SemanticServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

protocol SemanticServiceProtocol {
    func search(query: String, completion: @escaping ([Entity]?, Error?) -> Void)
}
