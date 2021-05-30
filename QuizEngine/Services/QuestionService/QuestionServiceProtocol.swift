//
//  QuestionServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 30.05.2021.
//

protocol QuestionServiceProtocol {
    func create(quizId: String, question: Question, completion: @escaping (Question?, Error?) -> Void)
    func update(
        quizId: String, questionId: Int, question: Question,
        completion: @escaping (Question?, Error?) -> Void
    )
    func delete(quizId: String, questionId: Int, completion: @escaping (Bool?, Error?) -> Void)
}
