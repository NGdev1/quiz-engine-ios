//
//  QuizPassing.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

import Foundation

class QuizPassing: Codable {
    init() {
        self.id = nil
        self.user = nil
        self.quiz = nil
        self.answers = []
    }

    var id: String?
    var user: Profile?
    var quiz: Quiz?
    var answers: [QuestionAnswer]

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? map.decode(String.self, forKey: .id)
        self.user = try? map.decode(Profile.self, forKey: .user)
        self.quiz = try? map.decode(Quiz.self, forKey: .quiz)
        self.answers = (try? map.decode([QuestionAnswer].self, forKey: .answers)) ?? []
    }
}
