//
//  QuestionOptionCell.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import UIKit

protocol QuestionOptionCellDelegate: AnyObject {}

final class QuestionOptionCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    weak var delegate: QuestionOptionCellDelegate?

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
        delegate: QuestionOptionCellDelegate,
        option: QuestionOption
    ) {
        self.delegate = delegate
        titleLabel.text = option.text
        subtitleLabel.text = Text.EditQuestionOption.isCorrect
    }
}
