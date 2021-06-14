//
//  SelectMethodModels.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

enum QuestionCreatingMethod {
    case bySearch
    case byMap
    case manually

    var title: String {
        switch self {
        case .bySearch:
            return Text.Methods.bySearch
        case .byMap:
            return Text.Methods.byMap
        case .manually:
            return Text.Methods.manually
        }
    }

    static let all: [QuestionCreatingMethod] = [.bySearch, .byMap, .manually]
}
