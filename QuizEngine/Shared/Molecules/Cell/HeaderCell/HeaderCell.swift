//
//  HeaderCell.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import UIKit

final class HeaderCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var titleLabel: UILabel!

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    private func setupStyle() {}

    // MARK: - Internal methods

    func configure(title: String) {
        titleLabel.text = title
    }
}
