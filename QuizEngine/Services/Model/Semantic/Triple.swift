//
//  Triple.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import Foundation

struct Triple: Decodable {
    let subject: Entity
    let predicate: Entity
    let object: Entity
}
