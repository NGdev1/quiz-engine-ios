//
//  AuthService.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import Moya

class AuthService: AuthServiceProtocol {
    let dataProvider = MoyaProvider<AuthApi>()

    func signIn(
        _ form: Auth.SignInForm,
        completion: @escaping (Auth.TokenDto?, Error?) -> Void
    ) {
        dataProvider.request(.signIn(form)) { result in
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
                    let response = try moyaResponse.map(Auth.TokenDto.self)
                    completion(response, nil)
                } catch {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    func signUp(
        _ form: Auth.SignUpForm,
        completion: @escaping (Auth.TokenDto?, Error?) -> Void
    ) {
        dataProvider.request(.signUp(form)) { result in
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
                    let response = try moyaResponse.map(Auth.TokenDto.self)
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
