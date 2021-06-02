//
//  QuizCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

import UIKit

protocol QuizCellSetupDelegate: AnyObject {
    func startQuiz()
    func reloadAction()
}

final class QuizCellSetup {
    private var entity: Quiz?
    var messageAboutError: String = .empty
    weak var delegate: QuizCellSetupDelegate?

    private var tableView: UITableView
    private let startButtonIndex: Int = 1

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

    func quizHeaderCell(_ cell: QuizHeaderCell, for indexPath: IndexPath) {
        guard let quiz = entity else { return }
        cell.configure(quiz: quiz, delegate: self)
    }

    func startCell(_ cell: PrimaryButtonCell, for indexPath: IndexPath) {
        cell.configure(text: Text.Quiz.start, index: startButtonIndex, isEnabled: true, delegate: self)
    }

    func authorHeaderCell(_ cell: HeaderCell, for indexPath: IndexPath) {
        cell.configure(title: Text.Quiz.author)
    }

    func authorCell(_ cell: ProfileCell, for indexPath: IndexPath) {
        guard let author = entity?.author else { return }
        cell.configure(delegate: self, profile: author)
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension QuizCellSetup: ErrorCellDelegate, QuizHeaderCellDelegate, ButtonCellDelegate,
    ProfileCellDelegate
{
    func buttonClicked(index: Int) {
        if index == startButtonIndex {
            delegate?.startQuiz()
        }
    }

    func reloadData() {
        delegate?.reloadAction()
    }
}
