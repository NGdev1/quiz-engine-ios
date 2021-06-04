//
//  QuizPassingCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 03.06.2021.
//

import UIKit

protocol QuizPassingCellSetupDelegate: AnyObject {
    func didSelectQuestion(_ question: Question, answer: QuestionAnswer?)
    func reloadAction()
}

final class QuizPassingCellSetup {
    private var entity: QuizPassing?
    var messageAboutError: String = .empty
    weak var delegate: QuizPassingCellSetupDelegate?
    private var tableView: UITableView

    var firstQuestionIndex: Int = 0

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

    func questionPassingCell(_ cell: QuestionPassingCell, for indexPath: IndexPath) {
        guard let question = entity?.questions[indexPath.row - firstQuestionIndex] else { return }
        let answer = entity?.answers.first(where: { item in
            guard let itemId = item.question?.id else { return false }
            return itemId == question.id
        })
        cell.configure(question: question, answer: answer, delegate: self)
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension QuizPassingCellSetup: ErrorCellDelegate, PassingHeaderCellDelegate, QuestionPassingCellDelegate {
    func didSelectQuestion(_ question: Question, answer: QuestionAnswer?) {
        delegate?.didSelectQuestion(question, answer: answer)
    }

    func reloadData() {
        delegate?.reloadAction()
    }
}
