//
//  SemanticServiceApi.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import Map
import Moya
import Storable

enum SemanticServiceApi {
    case getEntities(query: String, graphType: GraphType)
    case getEntitiesFromRegion(region: MapRegion, graphType: GraphType)
    case getQuestions(entityUri: String, graphType: GraphType)
}

extension SemanticServiceApi: TargetType {
    var baseURL: URL {
        return AppService.shared.app.baseURL
    }

    var path: String {
        switch self {
        case .getEntities:
            return "/semantic/search"
        case .getEntitiesFromRegion:
            return "/semantic/map"
        case .getQuestions:
            return "/semantic/questions"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getEntities, .getQuestions, .getEntitiesFromRegion:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .getEntities(query, graphType):
            return .requestCompositeData(
                bodyData: Data(),
                urlParameters: ["query": query, "graphType": graphType.rawValue]
            )
        case let .getEntitiesFromRegion(region, graphType):
            return .requestCompositeData(
                bodyData: (try? JSONEncoder().encode(region)) ?? Data(),
                urlParameters: ["graphType": graphType.rawValue]
            )
        case let .getQuestions(entityUri, graphType):
            return .requestCompositeData(
                bodyData: Data(),
                urlParameters: ["entityUri": entityUri, "graphType": graphType.rawValue]
            )
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
