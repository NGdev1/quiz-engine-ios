//
//  QuizCell.swift
//  SharedComponents
//
//  Created by Михаил Андреичев on 19.02.2020.
//

import UIKit

final class QuizCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var questionsCountLabel: UILabel!

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    private func setupStyle() {}

    // MARK: - Public methods

    func configure(_ quiz: Quiz) {
        nameLabel.text = quiz.title
        questionsCountLabel.text = quiz.description
    }
}
