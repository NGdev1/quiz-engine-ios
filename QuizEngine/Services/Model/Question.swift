//
//  Question.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import Foundation

class Question: Codable {
    init(id: Int?) {
        self.id = id
        self.text = nil
        self.options = []
    }

    var id: Int?
    var text: String?
    var options: [QuestionOption]?
}
