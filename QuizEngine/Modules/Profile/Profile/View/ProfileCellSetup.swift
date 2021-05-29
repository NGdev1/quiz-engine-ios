//
//  ProfileCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

protocol ProfileCellSetupDelegate: AnyObject {
    func editProfile()
    func reloadAction()
}

final class ProfileCellSetup {
    private var entity: Profile?
    var messageAboutError: String = .empty
    weak var delegate: ProfileCellSetupDelegate?

    private var tableView: UITableView

    private let buttonEditProfileIndex: Int = 0

    // MARK: - Init

    init(entity: Profile?, tableView: UITableView) {
        self.entity = entity
        self.tableView = tableView
    }

    // MARK: - Internal methods

    func updateProfile(_ entity: Profile) {
        self.entity = entity
    }

    // MARK: - Cells setup

    func profileHeaderCell(_ cell: ProfileHeaderCell, for indexPath: IndexPath) {
        guard let profile = entity else { return }
        cell.configure(profile: profile, delegate: self)
    }

    func editCell(_ cell: ButtonCell, for indexPath: IndexPath) {
        cell.configure(
            text: Text.Profile.edit, index: buttonEditProfileIndex,
            isEnabled: true, delegate: self
        )
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension ProfileCellSetup: ErrorCellDelegate, ProfileHeaderCellDelegate, ButtonCellDelegate {
    func buttonClicked(index: Int) {
        if index == buttonEditProfileIndex {
            delegate?.editProfile()
        }
    }

    func reloadData() {
        delegate?.reloadAction()
    }
}
