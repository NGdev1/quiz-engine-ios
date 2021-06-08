//
//  QuizPassingService.swift
//  QuizEngine
//
//  Created by Admin on 04.06.2021.
//

import Moya

class QuizPassingService: QuizPassingServiceProtocol {
    let dataProvider = MoyaProvider<QuizPassingApi>()

    func create(
        quizId: String,
        completion: @escaping (QuizPassing?, Error?) -> Void
    ) {
        dataProvider.request(.create(quizId: quizId)) { result in
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
                    let response = try moyaResponse.map(QuizPassing.self)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    func giveAnswer(
        quizId: String, passingId: Int, answer: QuestionAnswer,
        completion: @escaping (Bool?, Error?) -> Void
    ) {
        dataProvider.request(.giveAnswer(quizId: quizId, passingId: passingId, answer: answer)) { result in
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
                completion(true, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    func finish(
        quizId: String, passingId: Int,
        completion: @escaping (QuizPassing?, Error?) -> Void
    ) {
        dataProvider.request(.finish(quizId: quizId, passingId: passingId)) { result in
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
                    let response = try moyaResponse.map(QuizPassing.self)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    func get(
        quizId: String, passingId: Int,
        completion: @escaping (QuizPassing?, Error?) -> Void
    ) {
        dataProvider.request(.get(quizId: quizId, passingId: passingId)) { result in
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
                    let response = try moyaResponse.map(QuizPassing.self)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    func userResults(quizId: String, userId: Int, completion: @escaping (ParticipantResults?, Error?) -> Void) {
        dataProvider.request(.userResults(quizId: quizId, uesrId: userId)) { result in
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
                    let response = try moyaResponse.map(ParticipantResults.self)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
