//
//  QuizPassingCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

import UIKit

protocol QuizPassingCellSetupDelegate: AnyObject {
    func reloadAction()
}

final class QuizPassingCellSetup {
    private var entity: QuizPassing?
    var messageAboutError: String = .empty
    weak var delegate: QuizPassingCellSetupDelegate?

    private var tableView: UITableView

    // MARK: - Init

    init(entity: QuizPassing?, tableView: UITableView) {
        self.entity = entity
        self.tableView = tableView
    }

    // MARK: - Internal methods

    func updatEntity(_ entity: QuizPassing) {
        self.entity = entity
    }

    // MARK: - Cells setup

    func passingHeaderCell(_ cell: PassingHeaderCell, for indexPath: IndexPath) {
        guard let entity = entity else { return }
        cell.configure(passing: entity, delegate: self)
    }

    func questionsHeaderCell(_ cell: HeaderCell, for indexPath: IndexPath) {
        cell.configure(title: Text.QuizPassing.questions)
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension QuizPassingCellSetup: ErrorCellDelegate, PassingHeaderCellDelegate {
    func reloadData() {
        delegate?.reloadAction()
    }
}
