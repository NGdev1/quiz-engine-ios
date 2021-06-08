//
//  QuizPassingCell.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import UIKit

protocol QuizPassingCellDelegate: AnyObject {
    func didSelectQuizPasing(_ passing: QuizPassing)
}

final class QuizPassingCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var correctAnswersCountLabel: UILabel!
    @IBOutlet var percentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    weak var delegate: QuizPassingCellDelegate?
    var passing: QuizPassing?

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
        guard let passing = passing else { return }
        delegate?.didSelectQuizPasing(passing)
    }

    // MARK: - Internal methods

    func configure(passing: QuizPassing, delegate: QuizPassingCellDelegate) {
        self.delegate = delegate
        self.passing = passing
        correctAnswersCountLabel.text = Text.ParticipantResults.correctAnswersCount(
            "\(passing.correctAnswersCount) / \(passing.questionsCount)"
        )
        let percent: Float = Float(passing.correctAnswersCount) / Float(passing.questionsCount)
        percentLabel.text = "\(Int(percent * 100))%"
        dateLabel.text = passing.startDate?.getStringDescription()
    }
}
