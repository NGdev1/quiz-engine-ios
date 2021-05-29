//
//  SwitchCell.swift
//  SharedComponents
//
//  Created by Михаил Андреичев on 19.02.2020.
//

import UIKit

protocol SwitchCellDelegate: AnyObject {
    func switchValueChanged(tag: Int, value: Bool)
}

final class SwitchCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var label: UILabel!
    @IBOutlet var isOnSwitch: UISwitch!

    weak var delegate: SwitchCellDelegate?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        isOnSwitch.addTarget(
            self, action: #selector(switchValueChanged), for: .valueChanged
        )
    }

    @objc private func switchValueChanged() {
        delegate?.switchValueChanged(tag: tag, value: isOnSwitch.isOn)
    }

    // MARK: - Internal methods

    func configure(
        isOn: Bool,
        tag: Int,
        text: String,
        delegate: SwitchCellDelegate
    ) {
        self.tag = tag
        isOnSwitch.isOn = isOn
        label.text = text
        self.delegate = delegate
    }
}
