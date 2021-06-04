//
//  QuizPassingServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 04.06.2021.
//

protocol QuizPassingServiceProtocol {
    func create(quizId: String, completion: @escaping (QuizPassing?, Error?) -> Void)
    func giveAnswer(
        quizId: String, passingId: Int, answer: QuestionAnswer,
        completion: @escaping (QuestionAnswer?, Error?) -> Void
    )
}
