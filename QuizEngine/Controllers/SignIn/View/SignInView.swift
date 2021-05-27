//
//  SignInView.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import MDFoundation

final class SignInView: UIView {
    // MARK: - Properties

    lazy var bottomView: FixedBottomView = FixedBottomView(buttonText: Text.SignIn.submit)

    // MARK: - Xib Init

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    // MARK: - Private methods

    private func commonInit() {
        setupStyle()
    }

    private func setupStyle() {}

    // MARK: - Internal methods
}
