//
//  QuestionOption.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import Foundation

class QuestionOption: Codable {
    init() {
        self.id = nil
        self.text = .empty
        self.isCorrect = false
    }

    var id: Int?
    var tempId: Int? = Int.random(in: Int.min ... Int.max)
    var text: String?
    var isCorrect: Bool

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? map.decode(Int.self, forKey: .id)
        self.text = try? map.decode(String.self, forKey: .text)
        self.isCorrect = (try? map.decode(Bool.self, forKey: .isCorrect)) ?? false
    }
}
