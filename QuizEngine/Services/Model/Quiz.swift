//
//  Quiz.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Foundation

class Quiz: Codable {
    init() {
        self.id = nil
        self.title = nil
        self.author = nil
        self.description = nil
        self.startDate = nil
        self.isAnyOrder = true
        self.isPublic = true
        self.questions = []
    }

    var id: String?
    var title: String?
    var author: Profile?
    var description: String?
    var startDate: Date?
    var isAnyOrder: Bool?
    var isPublic: Bool?
    var questions: [Question]?
    // TODO: Add passings
}
