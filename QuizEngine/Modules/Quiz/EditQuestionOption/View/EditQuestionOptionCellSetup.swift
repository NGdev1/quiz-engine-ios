//
//  EditQuestionOptionCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

protocol EditQuestionOptionCellSetupDelegate: AnyObject {
    func addQuestion()
    func reloadAction()
}

final class EditQuestionOptionCellSetup: NSObject {
    private var entity: QuestionOption?
    var messageAboutError: String = .empty
    weak var delegate: EditQuestionOptionCellSetupDelegate?

    private var tableView: UITableView
    private let isCorrectSwitchTag: Int = 0x12
    private let textTag: Int = 100

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

    func textCell(_ cell: TextFieldCell, for indexPath: IndexPath) {
        cell.configure(
            delegate: self, text: entity?.text,
            placeholder: Text.EditQuestionOption.textPlaceholder, tag: textTag
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

extension EditQuestionOptionCellSetup: ErrorCellDelegate, UITextFieldDelegate,
    SwitchCellDelegate, QuestionCellDelegate, AddItemCellDelegate
{
    func addItem() {
        delegate?.addQuestion()
    }

    func switchValueChanged(tag: Int, value: Bool) {
        if tag == isCorrectSwitchTag {
            entity?.isCorrect = value
        }
    }

    func textField(
        _ textField: UITextField, shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let text: String = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? .empty
        if textField.tag == textTag {
            entity?.text = text
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = tableView.viewWithTag(textField.tag + 1) {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    func reloadData() {
        delegate?.reloadAction()
    }
}
