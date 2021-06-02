//
//  QuizServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol QuizServiceProtocol {
    func get(id: String, completion: @escaping (Quiz?, Error?) -> Void)
    func getOwnList(completion: @escaping ([Quiz]?, Error?) -> Void)
    func getPublicList(completion: @escaping ([Quiz]?, Error?) -> Void)
    func create(quiz: Quiz, completion: @escaping (Quiz?, Error?) -> Void)
    func update(id: String, quiz: Quiz, completion: @escaping (Quiz?, Error?) -> Void)
    func delete(id: String, completion: @escaping (Bool?, Error?) -> Void)
}
