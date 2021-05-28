//
//  AuthModels.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import Foundation

enum Auth {
    struct SignInForm: Encodable {
        let email: String
        let password: String
    }

    struct TokenDto: Decodable {
        let token: String
    }

    struct SignUpForm: Encodable {
        let fullName: String
        let email: String
        let password: String
    }
}
