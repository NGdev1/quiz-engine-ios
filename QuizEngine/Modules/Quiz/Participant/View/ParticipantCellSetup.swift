//
//  ParticipantCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import UIKit

protocol ParticipantCellSetupDelegate: AnyObject {
    func reloadAction()
}

final class ParticipantCellSetup {
    private var entity: ParticipantResults?
    var messageAboutError: String = .empty
    weak var delegate: ParticipantCellSetupDelegate?

    private var tableView: UITableView

    // MARK: - Init

    init(entity: ParticipantResults?, tableView: UITableView) {
        self.entity = entity
        self.tableView = tableView
    }

    // MARK: - Internal methods

    func updateParticipant(_ entity: ParticipantResults) {
        self.entity = entity
    }

    // MARK: - Cells setup

    func someCell(_ cell: UITableViewCell, for indexPath: IndexPath) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Some cell"
    }

    func otherCell(_ cell: UITableViewCell, for indexPath: IndexPath) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Other cell"
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension ParticipantCellSetup: ErrorCellDelegate {
    func reloadData() {
        delegate?.reloadAction()
    }
}
