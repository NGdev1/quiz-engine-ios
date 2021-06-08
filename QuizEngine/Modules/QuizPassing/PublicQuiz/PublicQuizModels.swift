//
//  PublicQuizModels.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import Foundation

struct QuizParticipantViewModel {
    let user: Profile
    let lastAttemptDate: Date
    let attemptsCount: Int

    static func getParticipants(from results: [QuizPassing]) -> [QuizParticipantViewModel] {
        let grouped: [Profile?: [QuizPassing]] = Dictionary(grouping: results, by: { result in
            result.user
        })
        return grouped.compactMap { key, value in
            guard let user = key,
                  let lastDate = value.sorted(by: { l, r in
                      guard let lDate = l.startDate, let rDate = r.startDate else { return false }
                      return lDate < rDate
                  }).last?.startDate
            else { return nil }
            return QuizParticipantViewModel(user: user, lastAttemptDate: lastDate, attemptsCount: value.count)
        }
    }
}
