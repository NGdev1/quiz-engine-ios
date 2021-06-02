//
//  PrimaryButtonCell.swift
//  General
//
//  Created by Михаил Андреичев on 19.02.2020.
//

import UIKit

final class PrimaryButtonCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var button: UIButton!

    var index: Int = 0
    weak var delegate: ButtonCellDelegate?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {}

    // MARK: - Action handlers

    private func addActionHandlers() {
        button.addTarget(
            self,
            action: #selector(buttonClick),
            for: .touchUpInside
        )
    }

    @objc func buttonClick() {
        delegate?.buttonClicked(index: index)
    }

    // MARK: - Internal methods

    func configure(
        text: String,
        index: Int,
        isEnabled: Bool,
        delegate: ButtonCellDelegate
    ) {
        button.setTitle(text, for: .normal)
        button.isEnabled = isEnabled
        self.index = index
        self.delegate = delegate
    }
}
