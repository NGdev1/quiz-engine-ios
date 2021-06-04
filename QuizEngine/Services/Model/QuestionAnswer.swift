//
//  QuestionAnswer.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

import Foundation

class QuestionAnswer: Codable {
    init(question: Question, option: QuestionOption) {
        self.id = nil
        self.question = question
        self.option = option
        self.passing = nil
    }

    var id: Int?
    var question: Question?
    var option: QuestionOption?
    var passing: QuizPassing?
}
