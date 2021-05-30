//
//  QuestionApi.swift
//  QuizEngine
//
//  Created by Admin on 30.05.2021.
//

import Moya
import Storable

enum QuestionApi {
    case create(quizId: String, question: Question)
    case update(quizId: String, questinoId: Int, question: Question)
    case delete(quizId: String, questionId: Int)
}

extension QuestionApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case .create:
            return "/question"
        case let .update(quizId, questinoId, _):
            return "/quiz/\(quizId)/question/\(questinoId)"
        case let .delete(quizId, questinoId):
            return "/quiz/\(quizId)/question/\(questinoId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .create, .update:
            return .post
        case .delete:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .create(_, question):
            return .requestJSONEncodable(question)
        case let .update(_, _, question):
            return .requestJSONEncodable(question)
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
