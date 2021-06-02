//
//  ProfileCell.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

import UIKit

protocol ProfileCellDelegate: AnyObject {}

final class ProfileCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!

    weak var delegate: ProfileCellDelegate?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {}

    // MARK: - Action handlers

    private func addActionHandlers() {}

    // MARK: - Internal methods

    func configure(delegate: ProfileCellDelegate, profile: Profile) {
        self.delegate = delegate
        avatarImageView.kf.setImage(with: profile.avatar?.url, placeholder: Assets.noPhoto.image)
        fullNameLabel.text = profile.fullName
    }
}
