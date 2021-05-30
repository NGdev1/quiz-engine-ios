//
//  EditQuizCellSetup.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

protocol EditQuizCellSetupDelegate: AnyObject {
    func addQuestion()
    func reloadAction()
}

final class EditQuizCellSetup: NSObject {
    private var entity: Quiz?
    var messageAboutError: String = .empty
    weak var delegate: EditQuizCellSetupDelegate?

    private var tableView: UITableView
    private let isPublicSwitchTag: Int = 0x12

    var firstQuestionIndexPath: Int = 0

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

    func nameCell(_ cell: TextFieldCell, for indexPath: IndexPath) {
        cell.configure(
            delegate: self, text: entity?.title,
            placeholder: Text.EditQuiz.namePlaceholder, tag: EditQuizView.textTag
        )
    }

    func isPublicQuizCell(_ cell: SwitchCell, for indexPath: IndexPath) {
        cell.configure(
            isOn: entity?.isPublic ?? true,
            tag: isPublicSwitchTag, text: Text.EditQuiz.isPublic,
            delegate: self
        )
    }

    func questionsTitle(_ cell: HeaderCell, for indexPath: IndexPath) {
        cell.configure(title: Text.EditQuiz.questionsHeader)
    }

    func questionCell(_ cell: QuestionCell, for indexPath: IndexPath) {
        let index = indexPath.row - firstQuestionIndexPath
        guard let question = entity?.questions?[index] else { return }
        cell.configure(delegate: self, question: question)
    }

    func addQuestonCell(_ cell: AddItemCell, for indexPath: IndexPath) {
        cell.configure(title: Text.EditQuiz.addQuestion, delegate: self)
    }

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension EditQuizCellSetup: ErrorCellDelegate, UITextFieldDelegate,
    SwitchCellDelegate, QuestionCellDelegate, AddItemCellDelegate
{
    func addItem() {
        delegate?.addQuestion()
    }

    func switchValueChanged(tag: Int, value: Bool) {
        if tag == isPublicSwitchTag {
            entity?.isPublic = value
        }
    }

    func textField(
        _ textField: UITextField, shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let text: String = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? .empty
        if textField.tag == EditQuizView.textTag {
            entity?.title = text
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
