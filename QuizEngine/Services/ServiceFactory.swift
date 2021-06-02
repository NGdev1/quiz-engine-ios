//
//  ServiceFactory.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

internal enum ServiceFactory {
    static let quizService: QuizServiceProtocol = QuizService()
    static let profileService: ProfileServiceProtocol = ProfileService()
    static let authService: AuthServiceProtocol = AuthService()
}
