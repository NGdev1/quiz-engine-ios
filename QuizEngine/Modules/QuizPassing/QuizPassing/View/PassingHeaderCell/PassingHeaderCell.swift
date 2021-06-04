//
//  PassingHeaderCell.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

import UIKit

protocol PassingHeaderCellDelegate: AnyObject {}

final class PassingHeaderCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var questionsCountLabel: UILabel!
    @IBOutlet var answeredCountLabel: UILabel!

    weak var delegate: PassingHeaderCellDelegate?

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

    func configure(passing: QuizPassing, delegate: PassingHeaderCellDelegate) {
        self.delegate = delegate
        titleLabel.text = passing.quiz?.title
        questionsCountLabel.text = Text.Quiz.questionsCount(passing.quiz?.questions.count ?? 0)
        answeredCountLabel.text = Text.QuizPassing.answeredCount(passing.answers.count)
    }
}
