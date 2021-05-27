//
//  AuthServiceMock.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import Foundation

class AuthServiceMock: AuthServiceProtocol {
    func signIn(_ form: Auth.SignInForm, completion: @escaping (Auth.TokenDto?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(Auth.TokenDto(token: "123"), nil)
        }
    }
}
