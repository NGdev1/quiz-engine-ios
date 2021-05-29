//
//  QuestionOption.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import Foundation

struct QuestionOption: Codable {
    init(id: String?) {
        self.id = id
        self.text = nil
        self.isCorrect = false
    }

    var id: String?
    var text: String?
    var isCorrect: Bool
}
