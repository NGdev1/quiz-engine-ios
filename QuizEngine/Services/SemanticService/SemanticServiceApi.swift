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
}

extension SemanticServiceApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case .getEntities:
            return "/semantic/search"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getEntities:
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
