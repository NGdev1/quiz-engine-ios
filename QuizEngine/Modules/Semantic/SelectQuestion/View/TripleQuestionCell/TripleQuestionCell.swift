//
//  TripleQuestionCell.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import UIKit

protocol TripleQuestionCellDelegate: AnyObject {}

final class TripleQuestionCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var correctAnswerLabel: UILabel!

    weak var delegate: TripleQuestionCellDelegate?

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

    func configure(triple: Triple, delegate: TripleQuestionCellDelegate) {
        self.delegate = delegate
        questionLabel.text = Text.SelectQuestion.questionText(triple.predicate.label, triple.subject.label)
        correctAnswerLabel.text = triple.object.label
    }
}
