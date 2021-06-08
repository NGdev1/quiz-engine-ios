//
//  ParticipantCell.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

import Kingfisher
import UIKit

protocol ParticipantCellDelegate: AnyObject {
    func didSelectParticipant(user: Profile)
}

final class ParticipantCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    weak var delegate: ParticipantCellDelegate?
    var user: Profile?

    // MARK: - Xib init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        addActionHandlers()
    }

    private func setupStyle() {}

    // MARK: - Action handlers

    private func addActionHandlers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapRecognizer)
    }

    @objc
    private func didTap() {
        guard let user = user else { return }
        delegate?.didSelectParticipant(user: user)
    }

    // MARK: - Internal methods

    func configure(delegate: ParticipantCellDelegate, participant: QuizParticipantViewModel) {
        self.delegate = delegate
        user = participant.user
        avatarImageView.kf.setImage(with: participant.user.avatar?.url, placeholder: Assets.noPhoto.image)
        fullNameLabel.text = participant.user.fullName
        subtitleLabel.text = Text.Quiz.participantDescription(
            participant.lastAttemptDate.getStringDescription(), participant.attemptsCount
        )
    }
}
