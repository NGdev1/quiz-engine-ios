//
//  SemanticServiceApi.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import Moya
import Storable

enum SemanticServiceApi {
    case getEntities(query: String)
    case getQuestions(entityUri: String)
}

extension SemanticServiceApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case .getEntities:
            return "/semantic/search"
        case .getQuestions:
            return "/semantic/questions"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getEntities, .getQuestions:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .getEntities(query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding())
        case let .getQuestions(entityUri):
            return .requestParameters(parameters: ["entityUri": entityUri], encoding: URLEncoding())
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
