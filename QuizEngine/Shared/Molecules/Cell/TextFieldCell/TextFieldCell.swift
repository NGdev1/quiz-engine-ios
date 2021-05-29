//
//  TextFieldCell.swift
//  Text
//
//  Created by Михаил Андреичев on 29.04.2020.
//

import SnapKit

final class TextFieldCell: UITableViewCell {
    // MARK: - Properties

    var textField: MDTextField = MDTextField()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .clear
        textField.isFloatingPlaceholder = true
    }

    private func addSubviews() {
        contentView.addSubview(textField)
    }

    private func makeConstraints() {
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Action handlers

    private func addActionHandlers() {}

    // MARK: - Internal methods

    func configure(
        delegate: UITextFieldDelegate,
        text: String,
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        errorMessage: String? = nil
    ) {
        textField.keyboardType = keyboardType
        textField.placeholder = placeholder
        textField.text = text
        textField.delegate = delegate
        if let errorMessage = errorMessage {
            textField.showError(errorMessage)
        } else {
            textField.resetError(animated: false)
        }
    }
}
