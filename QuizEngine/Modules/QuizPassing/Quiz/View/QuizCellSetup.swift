//
//  QuizCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

import UIKit

protocol QuizCellSetupDelegate: AnyObject {
    func reloadAction()
}

final class QuizCellSetup {
    private var entity: Quiz?
    var messageAboutError: String = .empty
    weak var delegate: QuizCellSetupDelegate?

    private var tableView: UITableView

    // MARK: - Init

    init(entity: Quiz?, tableView: UITableView) {
        self.entity = entity
        self.tableView = tableView
    }

    // MARK: - Internal methods

    func updateQuiz(_ entity: Quiz) {
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

extension QuizCellSetup: ErrorCellDelegate {
    func reloadData() {
        delegate?.reloadAction()
    }
}
