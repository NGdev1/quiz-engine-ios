//
//  QuestionCell.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import UIKit

protocol QuestionCellDelegate: AnyObject {}

final class QuestionCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    weak var delegate: QuestionCellDelegate?

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

    func configure(
        delegate: QuestionCellDelegate,
        question: Question
    ) {
        self.delegate = delegate
        titleLabel.text = question.text
        subtitleLabel.text = Text.Question.optionsCount(question.options?.count ?? 0)
    }
}
