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
        self.title = .empty
        self.author = nil
        self.description = .empty
        self.startDate = nil
        self.isAnyOrder = true
        self.isPublic = true
        self.questions = []
        self.results = []
        self.participants = []
    }

    var id: String?
    var title: String?
    var author: Profile?
    var description: String?
    var startDate: Date?
    var isAnyOrder: Bool?
    var isPublic: Bool?
    var questions: [Question]
    let results: [QuizPassing]
    let participants: [Participant]

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? map.decode(String.self, forKey: .id)
        self.title = try? map.decode(String.self, forKey: .title)
        self.author = try? map.decode(Profile.self, forKey: .author)
        self.description = try? map.decode(String.self, forKey: .description)
        self.isAnyOrder = try? map.decode(Bool.self, forKey: .isAnyOrder)
        self.isPublic = try? map.decode(Bool.self, forKey: .isPublic)
        self.questions = (try? map.decode([Question].self, forKey: .questions)) ?? []
        self.results = (try? map.decode([QuizPassing].self, forKey: .results)) ?? []
        if let startDateString = try? map.decode(String.self, forKey: .startDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
            self.startDate = formatter.date(from: startDateString)
        }
        self.participants = Participant.getParticipants(results: results)
    }
}
