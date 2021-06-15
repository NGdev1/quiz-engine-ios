//
//  SemanticService.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import Map
import Moya

class SemanticService: SemanticServiceProtocol {
    let dataProvider = MoyaProvider<SemanticServiceApi>()

    func search(query: String, graphType: GraphType, completion: @escaping ([Entity]?, Error?) -> Void) {
        dataProvider.request(.getEntities(query: query, graphType: graphType)) { result in
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

    func search(region: MapRegion, graphType: GraphType, completion: @escaping ([Entity]?, Error?) -> Void) {
        // print(String(data: (try? JSONEncoder().encode(region)) ?? Data(), encoding: .utf8) ?? "")
        dataProvider.request(.getEntitiesFromRegion(region: region, graphType: graphType)) { result in
            switch result {
            case let .success(moyaResponse):
                // print(String(data: moyaResponse.request?.httpBody ?? Data(), encoding: .utf8) ?? "")
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
                // print(String(data: error.response?.data ?? Data(), encoding: .utf8) ?? "")
                completion(nil, error)
            }
        }
    }

    func getQuestions(entityUri: String, graphType: GraphType, completion: @escaping ([Triple]?, Error?) -> Void) {
        dataProvider.request(.getQuestions(entityUri: entityUri, graphType: graphType)) { result in
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
                    let response = try moyaResponse.map([Triple].self)
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
