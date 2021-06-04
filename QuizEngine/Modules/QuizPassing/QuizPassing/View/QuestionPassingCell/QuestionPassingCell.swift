//
//  QuestionPassingCell.swift
//  QuizEngine
//
//  Created by Admin on 04.06.2021.
//

import UIKit

protocol QuestionPassingCellDelegate: AnyObject {
    func didSelectQuestion(_ question: Question, answer: QuestionAnswer?)
}

final class QuestionPassingCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var questionTextLabel: UILabel!
    @IBOutlet var hasAnswerLabel: UILabel!
    @IBOutlet var checkmarkImageView: UIImageView!

    var question: Question?
    var answer: QuestionAnswer?

    weak var delegate: QuestionPassingCellDelegate?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {}

    // MARK: - Action handlers

    private func addActionHandlers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTap))
        addGestureRecognizer(tapRecognizer)
    }

    @objc
    private func cellTap() {
        guard let queston = question else { return }
        delegate?.didSelectQuestion(queston, answer: answer)
    }

    // MARK: - Internal methods

    func configure(question: Question, answer: QuestionAnswer?, delegate: QuestionPassingCellDelegate) {
        self.delegate = delegate
        self.question = question
        self.answer = answer
        questionTextLabel.text = question.text
        hasAnswerLabel.text = answer == nil ? Text.QuizPassing.hasNoAnswer : Text.QuizPassing.hasAnswer
        checkmarkImageView.isHidden = answer == nil
    }
}
