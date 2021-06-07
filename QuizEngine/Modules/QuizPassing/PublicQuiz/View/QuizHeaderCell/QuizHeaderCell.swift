//
//  QuizHeaderCell.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

import UIKit

protocol QuizHeaderCellDelegate: AnyObject {}

final class QuizHeaderCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var numberOfQuestionsLabel: UILabel!

    weak var delegate: QuizHeaderCellDelegate?

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

    func configure(quiz: Quiz, delegate: QuizHeaderCellDelegate) {
        titleLabel.text = quiz.title
        descriptionLabel.text = quiz.description
        numberOfQuestionsLabel.text = Text.Quiz.questionsCount(quiz.questions.count)
        self.delegate = delegate
    }
}
