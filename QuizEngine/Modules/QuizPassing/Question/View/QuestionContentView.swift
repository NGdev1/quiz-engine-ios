//
//  QuestionContentView.swift
//  QuizEngine
//
//  Created by Admin on 05.06.2021.
//

import UIKit

final class QuestionContentView: UITableViewHeaderFooterView {
    // MARK: - Properties

    private lazy var questionTextLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.SFUIDisplay.regular.font(size: 18)
        label.numberOfLines = 0
        label.textColor = Assets.text.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    static let identifier: String = "QuestionContentView"

    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
        backgroundColor = Assets.background1.color
        contentView.backgroundColor = Assets.background1.color
    }

    private func addSubviews() {
        addSubview(questionTextLabel)
    }

    private func makeConstraints() {
        addConstraints([
            questionTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            questionTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            questionTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            questionTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }

    // MARK: - Internal methods

    func configure(text: String?) {
        questionTextLabel.text = text
    }
}
