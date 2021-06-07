//
//  QuizResultCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 06.06.2021.
//

import UIKit

protocol QuizResultCellSetupDelegate: AnyObject {
    func reloadAction()
}

final class QuizResultCellSetup {
    private var entity: QuizPassing?
    var messageAboutError: String = .empty
    weak var delegate: QuizResultCellSetupDelegate?

    private var tableView: UITableView

    // MARK: - Init

    init(entity: QuizPassing?, tableView: UITableView) {
        self.entity = entity
        self.tableView = tableView
    }

    // MARK: - Internal methods

    func updateQuizPassing(_ entity: QuizPassing) {
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

extension QuizResultCellSetup: ErrorCellDelegate {
    func reloadData() {
        delegate?.reloadAction()
    }
}
