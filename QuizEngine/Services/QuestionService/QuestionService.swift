//
//  QuestionService.swift
//  QuizEngine
//
//  Created by Admin on 30.05.2021.
//

import Moya

class QuestionService: QuestionServiceProtocol {
    let dataProvider = MoyaProvider<QuestionApi>()

    func create(
        quizId: String, question: Question,
        completion: @escaping (Question?, Error?) -> Void
    ) {
        dataProvider.request(.create(quizId: quizId, question: question)) { result in
            switch result {
            case let .success(moyaResponse):
                // print(String(data: moyaResponse.data, encoding: .utf8) ?? "")
                if (500 ... 599).contains(moyaResponse.statusCode) {
                    completion(nil, GeneralError.remoteError)
                    return
                }
                guard (200 ... 299).contains(moyaResponse.statusCode) else {
                    if let message = try? moyaResponse.map(String.self, atKeyPath: "message") {
                        completion(nil, CustomError(errorDescription: message))
                    } else {
                        completion(nil, GeneralError.requestError)
                    }
                    return
                }
                do {
                    let response = try moyaResponse.map(Question.self)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    func update(
        quizId: String, questionId: Int, question: Question,
        completion: @escaping (Question?, Error?) -> Void
    ) {
        dataProvider.request(.update(quizId: quizId, questinoId: questionId, question: question)) { result in
            switch result {
            case let .success(moyaResponse):
                // print(String(data: moyaResponse.data, encoding: .utf8) ?? "")
                if (500 ... 599).contains(moyaResponse.statusCode) {
                    completion(nil, GeneralError.remoteError)
                    return
                }
                guard (200 ... 299).contains(moyaResponse.statusCode) else {
                    if let message = try? moyaResponse.map(String.self, atKeyPath: "message") {
                        completion(nil, CustomError(errorDescription: message))
                    } else {
                        completion(nil, GeneralError.requestError)
                    }
                    return
                }
                do {
                    let response = try moyaResponse.map(Question.self)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    func delete(
        quizId: String, questionId: Int,
        completion: @escaping (Bool?, Error?) -> Void
    ) {
        dataProvider.request(.delete(quizId: quizId, questionId: questionId)) { result in
            switch result {
            case let .success(moyaResponse):
                if (500 ... 599).contains(moyaResponse.statusCode) {
                    completion(nil, GeneralError.remoteError)
                    return
                }
                guard (200 ... 299).contains(moyaResponse.statusCode) else {
                    if let message = try? moyaResponse.map(String.self, atKeyPath: "message") {
                        completion(nil, CustomError(errorDescription: message))
                    } else {
                        completion(nil, GeneralError.requestError)
                    }
                    return
                }
                completion(true, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
