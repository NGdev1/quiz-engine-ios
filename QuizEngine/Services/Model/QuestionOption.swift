//
//  QuestionOption.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import Foundation

class QuestionOption: Codable {
    init(id: Int?) {
        self.id = id
        self.text = .empty
        self.isCorrect = false
    }

    var id: Int?
    var text: String?
    var isCorrect: Bool
}
