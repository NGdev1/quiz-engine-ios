//
//  Quiz.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Foundation

struct Quiz: Codable {
    let id: String?
    let title: String?
    let author: Profile?
    let description: String?
    let startDate: Date?
    let isAnyOrder: Bool?
    let isPublic: Bool?
    // TODO: Add questions
    // TODO: Add passings
}
