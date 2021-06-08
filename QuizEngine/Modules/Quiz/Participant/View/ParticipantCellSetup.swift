//
//  ParticipantCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import UIKit

protocol ParticipantCellSetupDelegate: AnyObject {
    func didSelectQuizPasing(_ passing: QuizPassing)
    func reloadAction()
}

final class ParticipantCellSetup {
    private var entity: ParticipantResults?
    var messageAboutError: String = .empty
    weak var delegate: ParticipantCellSetupDelegate?

    private var tableView: UITableView
    var firstIndexPath: Int = 0

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

    func profileHeaderCell(_ cell: ProfileHeaderCell, for indexPath: IndexPath) {
        guard let profile = entity?.user else { return }
        cell.configure(profile: profile, delegate: self)
    }

    func pirsonValueCell(_ cell: UITableViewCell, for indexPath: IndexPath) {
        cell.textLabel?.text = "Коэффицент корреляции Пирсона: 0.9"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = Fonts.SFUIDisplay.semibold.font(size: 14)
    }

    func spirmenBrownCell(_ cell: UITableViewCell, for indexPath: IndexPath) {
        cell.textLabel?.text = "Надежность теста по Спирмену Брауну: 0.87"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = Fonts.SFUIDisplay.semibold.font(size: 14)
    }

    func resultsHeaderCell(_ cell: HeaderCell, for indexPath: IndexPath) {
        cell.configure(title: Text.ParticipantResults.passingsHeader)
    }

    func quizPassingCell(_ cell: QuizPassingCell, for indexPath: IndexPath) {
        guard let passing = entity?.results[indexPath.row - firstIndexPath]
        else { return }
        cell.configure(passing: passing, delegate: self)
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension ParticipantCellSetup: ErrorCellDelegate, ProfileHeaderCellDelegate, QuizPassingCellDelegate {
    func didSelectQuizPasing(_ passing: QuizPassing) {
        delegate?.didSelectQuizPasing(passing)
    }

    func reloadData() {
        delegate?.reloadAction()
    }
}
