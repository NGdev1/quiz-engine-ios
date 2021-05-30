//
//  ProfileApi.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Moya
import Storable

enum ProfileApi {
    case get
}

extension ProfileApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case .get:
            return "/user"
        }
    }

    var method: Moya.Method {
        switch self {
        case .get:
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
