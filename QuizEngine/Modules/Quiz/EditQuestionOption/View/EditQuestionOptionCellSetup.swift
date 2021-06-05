//
//  EditQuestionOptionCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

protocol EditQuestionOptionCellSetupDelegate: AnyObject {
    func reloadAction()
}

final class EditQuestionOptionCellSetup: NSObject {
    var messageAboutError: String = .empty

    private var entity: QuestionOption?
    private var tableView: UITableView
    private let isCorrectSwitchTag: Int = 0x12

    weak var delegate: EditQuestionOptionCellSetupDelegate?

    // MARK: - Init

    init(entity: QuestionOption?, tableView: UITableView) {
        self.entity = entity
        self.tableView = tableView
    }

    // MARK: - Internal methods

    func updateQuestionOption(_ entity: QuestionOption) {
        self.entity = entity
    }

    // MARK: - Cells setup

    func textCell(_ cell: TextAreaCell, for indexPath: IndexPath) {
        cell.configure(
            delegate: self, text: entity?.text,
            tag: EditQuestionOptionView.textTag, placeholder: Text.EditQuestionOption.textPlaceholder
        )
    }

    func isCorrectCell(_ cell: SwitchCell, for indexPath: IndexPath) {
        cell.configure(
            isOn: entity?.isCorrect ?? true,
            tag: isCorrectSwitchTag, text: Text.EditQuestionOption.isCorrect,
            delegate: self
        )
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension EditQuestionOptionCellSetup: ErrorCellDelegate, MDTextAreaDelegate,
    SwitchCellDelegate
{
    func switchValueChanged(tag: Int, value: Bool) {
        if tag == isCorrectSwitchTag {
            entity?.isCorrect = value
        }
    }

    func textDidChange(textArea: MDTextArea, text: String) {
        if textArea.tag == EditQuestionOptionView.textTag {
            entity?.text = text
        }
        DispatchQueue.main.async { [weak tableView] in
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
    }

    func reloadData() {
        delegate?.reloadAction()
    }
}
