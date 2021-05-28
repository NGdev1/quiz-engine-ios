//
//  ProfileServiceMock.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Foundation

class ProfileServiceMock: ProfileServiceProtocol {
    func get(completion: @escaping (Profile?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let result = Profile(
                id: 0, avatar: nil, fullName: "Ashot",
                email: "123@123", roles: Set(), isActive: true
            )
            completion(result, nil)
        }
    }
}
