//
//  ProfileView.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

final class ProfileView: UIView {
    // MARK: - Properties

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

    func displayProfile(_ profile: Profile) {
        // nameTextField.text = viewModel.name
    }
}
