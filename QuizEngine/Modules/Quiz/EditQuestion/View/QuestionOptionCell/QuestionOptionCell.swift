//
//  QuestionOptionCell.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import UIKit

protocol QuestionOptionCellDelegate: AnyObject {
    func didSelectOption(_ option: QuestionOption)
}

final class QuestionOptionCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    weak var delegate: QuestionOptionCellDelegate?
    var option: QuestionOption?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {}

    // MARK: - Action handlers

    private func addActionHandlers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapRecognizer)
    }

    @objc
    private func cellTapped() {
        guard let option = option else { return }
        delegate?.didSelectOption(option)
    }

    // MARK: - Internal methods

    func configure(
        delegate: QuestionOptionCellDelegate,
        option: QuestionOption
    ) {
        self.delegate = delegate
        self.option = option
        titleLabel.text = option.text
        subtitleLabel.text = option.isCorrect ? Text.QuestionOption.correct : Text.QuestionOption.notCorrect
    }
}
