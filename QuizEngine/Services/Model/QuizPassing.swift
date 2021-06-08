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
    var startDate: Date?
    var result: Float?
    var correctAnswersCount: Int
    var questionsCount: Int

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try map.decode(Int.self, forKey: .id)
        self.user = try? map.decode(Profile.self, forKey: .user)
        self.quiz = try? map.decode(Quiz.self, forKey: .quiz)
        let questions = (try? map.decode([Question].self, forKey: .questions)) ?? []
        let answers = (try? map.decode([QuestionAnswer].self, forKey: .answers)) ?? []
        self.result = try? map.decode(Float.self, forKey: .result)
        if let startDateString = try? map.decode(String.self, forKey: .startDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
            self.startDate = formatter.date(from: startDateString)
        }
        self.correctAnswersCount = (try? map.decode(Int.self, forKey: .correctAnswersCount)) ??
            answers.filter { $0.option?.isCorrect ?? false }.count
        self.questionsCount = (try? map.decode(Int.self, forKey: .questionsCount)) ?? questions.count

        self.questions = questions
        self.answers = answers
    }
}
