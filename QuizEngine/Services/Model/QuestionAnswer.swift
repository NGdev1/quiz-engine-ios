//
//  QuestionAnswer.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

import Foundation

class QuestionAnswer: Codable {
    init() {
        self.id = nil
        self.question = nil
        self.option = nil
        self.passing = nil
    }

    var id: String?
    var question: Question?
    var option: QuestionOption?
    var passing: QuizPassing?
}
