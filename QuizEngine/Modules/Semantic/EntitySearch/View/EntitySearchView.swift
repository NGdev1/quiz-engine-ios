//
//  EntitySearchView.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import UIKit

final class EntitySearchView: UIView {
    struct Appearance {}

    lazy var scrollView: MDScrollView = MDScrollView()
    lazy var queryTextField: MDTextField = {
        let textField: MDTextField = MDTextField()
        textField.isFloatingPlaceholder = true
        textField.placeholder = Text.EntitySearch.queryTextFieldPlaceholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .search
        return textField
    }()

    lazy var contentView: UIView = UIView()

    // MARK: - Properties

    // MARK: - Init

    override init(frame: CGRect = UIScreen.main.bounds) {
        super.init(frame: frame)
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
        addActionHandlers()
    }

    private func setupStyle() {
        backgroundColor = Assets.background1.color
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .always
        scrollView.alwaysBounceVertical = true
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(queryTextField)
    }

    private func makeConstraints() {
        scrollView.makeEdgesEqualToSuperview()

        contentView.makeEdgesEqualToSuperview()
        addConstraints([
            widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])

        contentView.addConstraints([
            queryTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            queryTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            queryTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            queryTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            queryTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        let dismissTapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboardAction)
        )
        addGestureRecognizer(dismissTapRecognizer)
    }

    @objc func dismissKeyboardAction() {
        endEditing(true)
    }

    // MARK: - Internal methods
}
