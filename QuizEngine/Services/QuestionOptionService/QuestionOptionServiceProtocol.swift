//
//  QuestionOptionServiceProtocol.swift
//  QuizEngine
//
//  Created by Admin on 30.05.2021.
//

protocol QuestionOptionServiceProtocol {
    func create(questionId: Int, option: QuestionOption, completion: @escaping (QuestionOption?, Error?) -> Void)
    func update(
        questionId: Int, optionId: Int, option: QuestionOption,
        completion: @escaping (QuestionOption?, Error?) -> Void
    )
    func delete(questionId: Int, optionId: Int, completion: @escaping (Bool?, Error?) -> Void)
}
