//
//  SelectMethodModels.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

enum QuestionCreatingMethod: String {
    case bySearch = "Поиск"
    case manually = "Вручную"

    static let all: [QuestionCreatingMethod] = [.bySearch, .manually]
}
