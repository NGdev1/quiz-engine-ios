//
//  AddItemCell.swift
//  QuizEngine
//
//  Created by Admin on 29.05.2021.
//

import UIKit

protocol AddItemCellDelegate: AnyObject {
    func addItem()
}

final class AddItemCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var addButton: UIButton!
    weak var delegate: AddItemCellDelegate?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {}

    // MARK: - Action handlers

    private func addActionHandlers() {
        addButton.addTarget(
            self, action: #selector(addButtonClicked), for: .touchUpInside
        )
    }

    @objc
    private func addButtonClicked() {
        delegate?.addItem()
    }

    // MARK: - Internal methods

    func configure(title: String, delegate: AddItemCellDelegate) {
        self.delegate = delegate
        addButton.setTitle(title, for: .normal)
    }
}
