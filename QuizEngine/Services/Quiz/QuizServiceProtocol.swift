//
//  QuizServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol QuizServiceProtocol {
    func get(id: String, completion: @escaping (Quiz?, Error?) -> Void)
    func getOwnList(completion: @escaping ([Quiz]?, Error?) -> Void)
}
