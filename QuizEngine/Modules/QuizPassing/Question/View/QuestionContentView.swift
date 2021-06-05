//
//  QuestionContentView.swift
//  QuizEngine
//
//  Created by Admin on 05.06.2021.
//

import UIKit

final class QuestionContentView: UIView {
    // MARK: - Properties

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.SFUIDisplay.regular.font(size: 18)
        label.numberOfLines = 0
        label.textColor = Assets.text.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(textLabel)
    }

    private func makeConstraints() {
        addConstraints([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }

    // MARK: - Internal methods

    func configure(text: String?) {
        textLabel.text = text
        height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
}
