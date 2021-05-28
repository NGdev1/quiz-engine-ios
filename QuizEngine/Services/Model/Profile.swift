//
//  Profile.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Foundation

struct Profile: Codable {
    enum Role: String, Codable {
        case user = "ROLE_USER"
        case admin = "ROLE_ADMIN"
    }

    let id: Int
    let avatar: Image?
    let fullName: String
    let email: String
    let roles: Set<Role>
    let isActive: Bool
}
