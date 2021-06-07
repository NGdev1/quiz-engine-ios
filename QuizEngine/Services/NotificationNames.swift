//
//  NotificationNames.swift
//  QuizEngine
//
//  Created by Admin on 30.05.2021.
//

import Foundation

extension Notification.Name {
    static let userChangedQuizList = NSNotification.Name("UserChangedQuizList")
    static let userChangedQuiz = NSNotification.Name("UserChangedQuiz")
    static let userFinishedQuiz = NSNotification.Name("UserFinishedQuiz")
}
