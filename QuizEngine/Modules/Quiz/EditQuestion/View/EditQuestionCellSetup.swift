//
//  EditQuestionCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

protocol EditQuestionCellSetupDelegate: AnyObject {
    func didSelectOption(_ option: QuestionOption)
    func addOption()
    func reloadAction()
}

final class EditQuestionCellSetup: NSObject {
    private var entity: Question?
    var messageAboutError: String = .empty
    weak var delegate: EditQuestionCellSetupDelegate?

    private var tableView: UITableView

    var firstOptionIndexPath: Int = 0

    // MARK: - Init

    init(entity: Question?, tableView: UITableView) {
        self.entity = entity
        self.tableView = tableView
    }

    // MARK: - Internal methods

    func updateQuestion(_ entity: Question) {
        self.entity = entity
    }

    // MARK: - Cells setup

    func textCell(_ cell: TextFieldCell, for indexPath: IndexPath) {
        cell.configure(
            delegate: self, text: entity?.text,
            placeholder: Text.EditQuestion.textPlaceholder, tag: EditQuestionView.textTag
        )
    }

    func optionsTitle(_ cell: HeaderCell, for indexPath: IndexPath) {
        cell.configure(title: Text.EditQuestion.optionsTitle)
    }

    func questionOptionCell(_ cell: QuestionOptionCell, for indexPath: IndexPath) {
        let index = indexPath.row - firstOptionIndexPath
        guard let option = entity?.options[index] else { return }
        cell.configure(delegate: self, option: option)
    }

    func addOptionCell(_ cell: AddItemCell, for indexPath: IndexPath) {
        cell.configure(title: Text.EditQuestion.addOption, delegate: self)
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension EditQuestionCellSetup: ErrorCellDelegate, UITextFieldDelegate,
    QuestionOptionCellDelegate, AddItemCellDelegate
{
    func didSelectOption(_ option: QuestionOption) {
        delegate?.didSelectOption(option)
    }

    func addItem() {
        delegate?.addOption()
    }

    func textField(
        _ textField: UITextField, shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let text: String = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? .empty
        if textField.tag == EditQuestionView.textTag {
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
