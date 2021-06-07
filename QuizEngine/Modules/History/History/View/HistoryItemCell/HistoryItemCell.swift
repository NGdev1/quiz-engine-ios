//
//  HistoryItemCell.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

import UIKit

final class HistoryItemCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var quizNameLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!

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

    func configure(historyItem: QuizPassing) {
        dateLabel.text = historyItem.startDate?.getStringDescription()
        quizNameLabel.text = historyItem.quiz?.title
        resultLabel.text = Text.History.itemResult(Int((historyItem.result ?? 0.0) * 100))
    }
}
