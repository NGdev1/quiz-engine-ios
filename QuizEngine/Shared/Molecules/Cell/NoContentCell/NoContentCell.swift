//
//  NoContentCell.swift
//  General
//
//  Created by Михаил Андреичев on 06.03.2020.
//

import MDFoundation
import SnapKit

final class NoContentCell: UITableViewCell {
    // MARK: - Init

    lazy var noContentLabel: UILabel = {
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
        contentView.addSubview(noContentLabel)
    }

    private func makeConstraints() {
        noContentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(28)
            make.height.equalTo(120)
        }
    }

    // MARK: - Public methods

    func configure(text: String, height: CGFloat? = nil) {
        noContentLabel.text = text
        if let height = height {
            noContentLabel.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
    }
}
