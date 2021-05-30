//
//  QuestionOptionService.swift
//  QuizEngine
//
//  Created by Admin on 30.05.2021.
//

import Moya

class QuestionOptionService: QuestionOptionServiceProtocol {
    let dataProvider = MoyaProvider<QuestionOptionApi>()

    func create(
        questionId: Int, option: QuestionOption,
        completion: @escaping (QuestionOption?, Error?) -> Void
    ) {
        dataProvider.request(.create(questionId: questionId, option: option)) { result in
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
                do {
                    let response = try moyaResponse.map(QuestionOption.self)
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
        questionId: Int, optionId: Int, option: QuestionOption,
        completion: @escaping (QuestionOption?, Error?) -> Void
    ) {
        dataProvider.request(.update(questionId: questionId, optionId: optionId, option: option)) { result in
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
                do {
                    let response = try moyaResponse.map(QuestionOption.self)
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
        questionId: Int, optionId: Int,
        completion: @escaping (Bool?, Error?) -> Void
    ) {
        dataProvider.request(.delete(questionId: questionId, optionId: optionId)) { result in
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
