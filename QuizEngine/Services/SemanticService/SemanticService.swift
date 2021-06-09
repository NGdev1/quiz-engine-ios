//
//  SemanticService.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import Moya

class SemanticService: SemanticServiceProtocol {
    let dataProvider = MoyaProvider<SemanticServiceApi>()

    func search(query: String, completion: @escaping ([Entity]?, Error?) -> Void) {
        dataProvider.request(.getEntities(query: query)) { result in
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
                    let response = try moyaResponse.map([Entity].self)
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
