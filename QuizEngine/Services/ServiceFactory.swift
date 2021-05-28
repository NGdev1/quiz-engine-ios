//
//  ServiceFactory.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

internal enum ServiceFactory {
    static let quizService: QuizServiceProtocol = QuizServiceMock()
    static let profileService: ProfileServiceProtocol = ProfileServiceMock()
    static let authService: AuthServiceProtocol = AuthService()
}
