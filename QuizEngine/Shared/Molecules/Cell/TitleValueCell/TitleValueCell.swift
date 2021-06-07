//
//  TitleValueCell.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import UIKit

final class TitleValueCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

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

    func configure(title: String?, value: String?) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
