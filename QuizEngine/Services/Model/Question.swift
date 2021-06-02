//
//  Question.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import Foundation

class Question: Codable {
    init() {
        self.id = nil
        self.text = .empty
        self.options = []
    }

    var id: Int?
    var text: String?
    var tempId: Int? = Int.random(in: Int.min ... Int.max)
    var options: [QuestionOption]

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? map.decode(Int.self, forKey: .id)
        self.text = try? map.decode(String.self, forKey: .text)
        self.options = (try? map.decode([QuestionOption].self, forKey: .options)) ?? []
    }
}
