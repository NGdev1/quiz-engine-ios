//
//  ErrorCell.swift
//  General
//
//  Created by Михаил Андреичев on 31.01.2020.
//

import UIKit

protocol ErrorCellDelegate: AnyObject {
    func reloadData()
}

final class ErrorCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: ErrorCellDelegate?

    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tryAgainButton: UIButton!

    // MARK: - Xib Init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {
        tryAgainButton.setTitle(Text.Errors.tryAgain, for: .normal)
        separatorInset = UIEdgeInsets(
            top: 0, left: UIScreen.main.bounds.width,
            bottom: 0, right: 0
        )
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        tryAgainButton.addTarget(
            self,
            action: #selector(tryAgainButtonClick),
            for: .touchUpInside
        )
    }

    @objc private func tryAgainButtonClick() {
        delegate?.reloadData()
    }

    // MARK: - Internal methods

    func configure(with message: String) {
        messageLabel.text = message
    }
}
