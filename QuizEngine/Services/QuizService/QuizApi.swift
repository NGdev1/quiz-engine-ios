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
    case create(quiz: Quiz)
    case update(id: String, quiz: Quiz)
    case delete(id: String)
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
        case .create:
            return "/quiz"
        case let .update(id, _):
            return "/quiz/\(id)"
        case let .delete(id):
            return "/quiz/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .get, .ownList:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
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
        case let .create(quiz):
            return .requestJSONEncodable(quiz)
        case let .update(_, quiz):
            return .requestJSONEncodable(quiz)
        case .delete:
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
