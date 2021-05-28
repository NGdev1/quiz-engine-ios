//
//  QuizServiceMock.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Foundation

class QuizServiceMock: QuizServiceProtocol {
    func get(id: String, completion: @escaping (Quiz?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(nil, nil)
        }
    }

    func getOwnList(completion: @escaping ([Quiz]?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion([], nil)
        }
    }
}
