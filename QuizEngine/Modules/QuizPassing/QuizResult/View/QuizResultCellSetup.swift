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

    var firstQuestionIndex: Int = 0

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

    func dateCell(_ cell: TitleValueCell, for indexPath: IndexPath) {
        cell.configure(title: Text.QuizResult.date, value: entity?.startDate?.getStringDescription())
    }

    func questionsCountCell(_ cell: TitleValueCell, for indexPath: IndexPath) {
        cell.configure(title: Text.QuizResult.questionsCount, value: "\(entity?.questions.count ?? 0)")
    }

    func correctCountCell(_ cell: TitleValueCell, for indexPath: IndexPath) {
        let correctCount: Int = (entity?.answers ?? []).filter { $0.option?.isCorrect ?? false }.count
        cell.configure(title: Text.QuizResult.correctCount, value: "\(correctCount)")
    }

    func percentCell(_ cell: TitleValueCell, for indexPath: IndexPath) {
        cell.configure(title: Text.QuizResult.percent, value: "\(Int((entity?.result ?? 0.0) * 100))%")
    }

    func answersHeaderCell(_ cell: HeaderCell, for indexPath: IndexPath) {
        cell.configure(title: Text.QuizResult.answersHeader)
    }

    func answerCell(_ cell: AnswerCell, for indexPath: IndexPath) {
        guard let entity = entity else { return }
        let question: Question = entity.questions[indexPath.row - firstQuestionIndex]
        let answer: QuestionAnswer? = entity.answers.first { $0.question?.id == question.id }
        cell.configure(question: question, answer: answer, delegate: self)
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension QuizResultCellSetup: ErrorCellDelegate, AnswerCellDelegate {
    func reloadData() {
        delegate?.reloadAction()
    }
}
