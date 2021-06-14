//
//  SelectEntityMethod.swift
//  QuizEngine
//
//  Created by Admin on 14.06.2021.
//

import Foundation
import Map

enum SelectEntityMethod {
    case query(text: String)
    case map(region: MapRegion)
}
