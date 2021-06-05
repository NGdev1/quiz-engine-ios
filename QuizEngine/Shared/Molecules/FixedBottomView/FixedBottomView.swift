//
//  FixedBottomView.swift
//  Orders
//
//  Created by Михаил Андреичев on 03.03.2020.
//

import SnapKit
import UIKit

final class FixedBottomView: UIView {
    // MARK: - Properties

    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.snp.contentHuggingVerticalPriority += 100
        button.backgroundColor = Assets.baseTint1.color
        button.setTitleColor(Assets.background1.color, for: .normal)
        button.titleLabel?.font = Fonts.SFUIDisplay.semibold.font(size: 18)
        button.cornerRadius = 12
        return button
    }()

    // MARK: - Init

    init(buttonText: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        setupStyle(buttonText: buttonText)
        addSubviews()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle(buttonText: String) {
        autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        actionButton.setTitle(buttonText, for: .normal)
        backgroundColor = Assets.background1.color
        addShadow(ofColor: Assets.shadow.color, radius: 8, offset: CGSize(width: 0, height: -4), opacity: 0.05)
        snp.contentHuggingVerticalPriority += 100
    }

    private func addSubviews() {
        addSubview(actionButton)
    }

    private func makeConstraints() {
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.leading.top.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }

    // MARK: - Internal methods

    func setEnabled(_ enabled: Bool) {
        actionButton.backgroundColor = enabled ? Assets.baseTint1.color : Assets.gray.color
        actionButton.isEnabled = enabled
    }

    // MARK: - Overriden properties

    override var intrinsicContentSize: CGSize { .zero }
}
