//
//  TextAreaCell.swift
//  General
//
//  Created by Михаил Андреичев on 19.02.2020.
//

import UIKit

final class TextAreaCell: UITableViewCell {
    enum Appearance {
        static let doneButtonHeight: CGFloat = 45
    }

    // MARK: - Properties

    private var textArea: MDTextArea = MDTextArea()

    lazy var textInputAccessoryView: UIView = {
        let inputAccessoryView = UIToolbar(
            frame: CGRect(
                width: UIScreen.main.bounds.width,
                height: Appearance.doneButtonHeight
            )
        )
        let barButton = UIBarButtonItem(
            title: Text.Common.hide, style: .plain,
            target: self, action: #selector(hideKeyboard)
        )
        inputAccessoryView.tintColor = Assets.baseTint1.color
        inputAccessoryView.barTintColor = Assets.background1.color
        inputAccessoryView.items = [
            UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                target: nil,
                action: nil
            ), barButton,
        ]
        return inputAccessoryView
    }()

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
        textArea.isScrollEnabled = false
        textArea.customInputAccessoryView = textInputAccessoryView
        separatorInset = UIEdgeInsets(
            top: 0, left: UIScreen.main.bounds.width,
            bottom: 0, right: 0
        )
    }

    private func addSubviews() {
        contentView.addSubview(textArea)
    }

    private func makeConstraints() {
        textArea.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }

    // MARK: - Action handlers

    private func addActionHandlers() {}

    @objc func hideKeyboard() {
        endEditing(true)
    }

    // MARK: - Internal methods

    func configure(
        delegate: MDTextAreaDelegate,
        text: String,
        placeholder: String
    ) {
        textArea.placeholder = placeholder
        textArea.text = text
        textArea.delegate = delegate
    }
}
