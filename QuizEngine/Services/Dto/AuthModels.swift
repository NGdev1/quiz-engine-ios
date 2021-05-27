//
//  AuthModels.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import Foundation

enum Auth {
    struct SignInForm: Encodable {
        var email: String
        var password: String
    }

    struct TokenDto {
        let token: String
    }

    struct SignUpForm: Encodable {}
}
