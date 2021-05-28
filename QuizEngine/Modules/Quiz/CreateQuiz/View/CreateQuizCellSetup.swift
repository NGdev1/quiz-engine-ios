//
//  CreateQuizCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

protocol CreateQuizCellSetupDelegate: AnyObject {
    func reloadAction()
}

final class CreateQuizCellSetup {
    private var entity: Quiz?
    var messageAboutError: String = .empty
    weak var delegate: CreateQuizCellSetupDelegate?

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

extension CreateQuizCellSetup: ErrorCellDelegate {
    func reloadData() {
        delegate?.reloadAction()
    }
}
