//
//  QuizPassingApi.swift
//  QuizEngine
//
//  Created by Admin on 04.06.2021.
//

import Moya
import Storable

enum QuizPassingApi {
    case create(quizId: String)
    case giveAnswer(quizId: String, passingId: Int, answer: QuestionAnswer)
}

extension QuizPassingApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case let .create(quizId):
            return "/quiz/\(quizId)/passing"
        case let .giveAnswer(quizId, passingId, _):
            return "/quiz/\(quizId)/passing/\(passingId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .create, .giveAnswer:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .create:
            return .requestPlain
        case let .giveAnswer(_, _, answer):
            return .requestJSONEncodable(answer)
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
