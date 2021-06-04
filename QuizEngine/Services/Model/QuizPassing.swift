//
//  QuizPassing.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

import Foundation

class QuizPassing: Codable {
    var id: Int
    var user: Profile?
    var quiz: Quiz?
    var questions: [Question]
    var answers: [QuestionAnswer]

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try map.decode(Int.self, forKey: .id)
        self.user = try? map.decode(Profile.self, forKey: .user)
        self.quiz = try? map.decode(Quiz.self, forKey: .quiz)
        self.questions = (try? map.decode([Question].self, forKey: .questions)) ?? []
        self.answers = (try? map.decode([QuestionAnswer].self, forKey: .answers)) ?? []
    }
}
