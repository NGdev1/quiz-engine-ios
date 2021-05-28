//
//  ProfileHeaderCell.swift
//  SharedComponents
//
//  Created by Михаил Андреичев on 19.02.2020.
//

import Kingfisher
import UIKit

protocol ProfileHeaderCellDelegate: AnyObject {}

final class ProfileHeaderCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    weak var delegate: ProfileHeaderCellDelegate?

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

    func configure(
        profile: Profile,
        delegate: ProfileHeaderCellDelegate
    ) {
        self.delegate = delegate
        fullNameLabel.text = profile.fullName
        emailLabel.text = profile.email
        avatarImageView.kf.setImage(with: profile.avatar?.url, placeholder: Assets.noPhoto.image)
    }
}
