//
//  QuizApi.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Moya
import Storable

enum QuizApi {
    case get(id: String)
    /// Список собственных викторин
    case ownList
}

extension QuizApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case let .get(id):
            return "/quiz/\(id)"
        case .ownList:
            return "/quiz/own-list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .get:
            return .get
        case .ownList:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .get:
            return .requestPlain
        case .ownList:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        if let userToken = AppService.shared.app.accessToken {
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(userToken)",
            ]
        } else {
            return ["Content-Type": "application/json"]
        }
    }
}
