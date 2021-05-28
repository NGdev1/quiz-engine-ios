//
//  ProfileView.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import Kingfisher
import MDFoundation

final class ProfileView: UIView {
    // MARK: - Properties

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

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
        fullNameLabel.text = .empty
        emailLabel.text = .empty
        avatarImageView.image = Assets.noPhoto.image
    }

    // MARK: - Internal methods

    func displayProfile(_ profile: Profile) {
        fullNameLabel.text = profile.fullName
        emailLabel.text = profile.email
        avatarImageView.kf.setImage(with: profile.avatar?.url, placeholder: Assets.noPhoto.image)
    }
}
