//
//  QuestionCell.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import UIKit

protocol QuestionCellDelegate: AnyObject {
    func didSelectQuestion(_ question: Question)
}

final class QuestionCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    weak var delegate: QuestionCellDelegate?
    var question: Question?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        addActionHandlers()
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapRecognizer)
    }

    @objc
    private func cellTapped() {
        guard let question = question else { return }
        delegate?.didSelectQuestion(question)
    }

    // MARK: - Internal methods

    func configure(
        delegate: QuestionCellDelegate,
        question: Question
    ) {
        self.delegate = delegate
        self.question = question
        titleLabel.text = question.text
        subtitleLabel.text = Text.Question.optionsCount(question.options.count)
    }
}
