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
    case finish(quizId: String, passingId: Int)
    case get(quizId: String, passingId: Int)
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
            return "/quiz/\(quizId)/passing/\(passingId)/answer"
        case let .finish(quizId, passingId):
            return "/quiz/\(quizId)/passing/\(passingId)/finish"
        case let .get(quizId, passingId):
            return "/quiz/\(quizId)/passing/\(passingId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .create, .giveAnswer, .finish:
            return .post
        case .get:
            return .get
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
        case .finish:
            return .requestPlain
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
