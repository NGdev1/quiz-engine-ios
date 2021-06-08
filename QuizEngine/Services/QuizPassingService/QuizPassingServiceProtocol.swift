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
        completion: @escaping (Bool?, Error?) -> Void
    )
    func finish(quizId: String, passingId: Int, completion: @escaping (QuizPassing?, Error?) -> Void)
    func get(quizId: String, passingId: Int, completion: @escaping (QuizPassing?, Error?) -> Void)
    func userResults(quizId: String, userId: Int, completion: @escaping (ParticipantResults?, Error?) -> Void)
}
