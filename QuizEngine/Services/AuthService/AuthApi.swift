//
//  AuthApi.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import Moya
import Storable

enum AuthApi {
    /// Регистрация
    case signIn(Auth.SignInForm)
    /// Вход
    case signUp(Auth.SignUpForm)
}

extension AuthApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case .signUp:
            return "/register"
        case .signIn:
            return "/auth"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .signUp(data):
            return .requestJSONEncodable(data)
        case let .signIn(data):
            return .requestJSONEncodable(data)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
