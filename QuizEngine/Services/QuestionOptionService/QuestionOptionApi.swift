//
//  QuestionOptionApi.swift
//  QuizEngine
//
//  Created by Admin on 30.05.2021.
//

import Moya
import Storable

enum QuestionOptionApi {
    case create(questionId: Int, option: QuestionOption)
    case update(questionId: Int, optionId: Int, option: QuestionOption)
    case delete(questionId: Int, optionId: Int)
}

extension QuestionOptionApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case let .create(questinoId, _):
            return "/question/\(questinoId)"
        case let .update(questinoId, optionId, _):
            return "/question/\(questinoId)/option/\(optionId)"
        case let .delete(questinoId, optionId):
            return "/question/\(questinoId)/question/\(optionId)"
        }
    }

    var method: Moya.Method {
        switch self {
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
