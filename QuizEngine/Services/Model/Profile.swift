//
//  Profile.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Foundation

struct Profile: Codable, Hashable {
    enum Role: String, Codable {
        case user = "ROLE_USER"
        case admin = "ROLE_ADMIN"
    }

    let id: Int
    let avatar: Image?
    let fullName: String
    let email: String
    let roles: Set<Role>?
    let isActive: Bool
    let registrationDate: Date?
    let quizzesCount: Int?
    let quizzesPassedCount: Int?

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try map.decode(Int.self, forKey: .id)
        self.avatar = try? map.decode(Image.self, forKey: .avatar)
        self.fullName = try map.decode(String.self, forKey: .fullName)
        self.email = try map.decode(String.self, forKey: .email)
        self.roles = try? map.decode(Set<Role>.self, forKey: .roles)
        self.isActive = (try? map.decode(Bool.self, forKey: .isActive)) ?? true
        if let registrationDateString = try? map.decode(String.self, forKey: .registrationDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
            self.registrationDate = formatter.date(from: registrationDateString)
        } else {
            self.registrationDate = nil
        }
        self.quizzesCount = try? map.decode(Int.self, forKey: .quizzesCount)
        self.quizzesPassedCount = try? map.decode(Int.self, forKey: .quizzesPassedCount)
    }

    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }
}
