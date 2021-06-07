//
//  AnswerCell.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

import UIKit

protocol AnswerCellDelegate: AnyObject {}

final class AnswerCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var questionTextLabel: UILabel!
    @IBOutlet var answerOptionTitleLabel: UILabel!
    @IBOutlet var isCorrectLabel: UILabel!

    weak var delegate: AnswerCellDelegate?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {}

    // MARK: - Action handlers

    private func addActionHandlers() {}

    // MARK: - Internal methods

    func configure(question: Question, answer: QuestionAnswer?, delegate: AnswerCellDelegate) {
        self.delegate = delegate
        questionTextLabel.text = question.text
        if let answer = answer {
            answerOptionTitleLabel.text = answer.option?.text
            if answer.option?.isCorrect == true {
                isCorrectLabel.text = Text.QuizResult.answerCorrect
                isCorrectLabel.textColor = Assets.correct.color
            } else {
                let correctAnswer: String = question.options.first { $0.isCorrect }?.text ?? .empty
                isCorrectLabel.text = Text.QuizResult.answerIncorrect(correctAnswer)
                isCorrectLabel.textColor = Assets.incorrect.color
            }
        } else {
            answerOptionTitleLabel.text = Text.QuizResult.answerIsNotGiven
            let correctAnswer: String = question.options.first { $0.isCorrect }?.text ?? .empty
            isCorrectLabel.text = Text.QuizResult.answerIncorrect(correctAnswer)
            isCorrectLabel.textColor = Assets.incorrect.color
        }
    }
}
