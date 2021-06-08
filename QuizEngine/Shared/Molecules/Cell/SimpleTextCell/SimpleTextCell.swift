//
//  SimpleTextCell.swift
//  General
//
//  Created by Михаил Андреичев on 06.03.2020.
//

import MDFoundation
import SnapKit

final class SimpleTextCell: UITableViewCell {
    // MARK: - Init

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.SFUIDisplay.bold.font(size: 18)
        label.textColor = Assets.gray.color
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

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

    // MARK: - Private methods

    private func setupStyle() {
        backgroundColor = .clear
        selectionStyle = .none
        separatorInset = UIEdgeInsets(
            top: 0, left: UIScreen.main.bounds.width,
            bottom: 0, right: 0
        )
    }

    private func addSubviews() {
        contentView.addSubview(messageLabel)
    }

    private func makeConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(100)
        }
    }

    // MARK: - Public methods

    func configure(text: String, topAndBottomInsets: CGFloat? = nil) {
        messageLabel.text = text
        if let insets = topAndBottomInsets {
            messageLabel.snp.updateConstraints { make in
                make.top.bottom.equalToSuperview().inset(insets)
            }
        }
    }
}
