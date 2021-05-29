//
//  TitleValueCell.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import UIKit

protocol TitleValueCellDelegate: AnyObject {}

final class TitleValueCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: TitleValueCellDelegate?

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
        delegate: TitleValueCellDelegate,
        title: String, value: String
    ) {
        self.delegate = delegate
    }
}
