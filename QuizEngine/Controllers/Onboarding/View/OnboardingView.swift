//
//  OnboardingView.swift
//  QuizEngine
//
//  Created by Admin on 27.05.2021.
//

import UIKit

final class OnboardingView: UIView {
    // MARK: - Properties

    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var loginWithEmailButton: UIButton!
    @IBOutlet var registrationButton: UIButton!

    // MARK: - Xib Init

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    // MARK: - Private methods

    private func commonInit() {
        setupStyle()
    }

    private func setupStyle() {
        descriptionLabel.text = Text.Onboarding.description
        loginWithEmailButton.setTitle(Text.Onboarding.continueWithEmail, for: .normal)
        registrationButton.setTitle(Text.Onboarding.registration, for: .normal)
    }
}
