//
//  Question.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import Foundation

struct Question: Codable {
    init(id: String?) {
        self.id = id
        self.text = nil
        self.options = []
    }

    var id: String?
    var text: String?
    var options: [QuestionOption]?
}
