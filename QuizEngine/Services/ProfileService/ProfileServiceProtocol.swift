//
//  ProfileServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

protocol ProfileServiceProtocol {
    func get(completion: @escaping (Profile?, Error?) -> Void)
}
