//
//  ParticipantResults.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

import Foundation

struct ParticipantResults: Codable {
    let user: Profile
    let results: [QuizPassing]
}
