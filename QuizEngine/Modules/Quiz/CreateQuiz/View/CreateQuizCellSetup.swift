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

final class CreateQuizCellSetup: NSObject {
    private var entity: Quiz?
    var messageAboutError: String = .empty
    weak var delegate: CreateQuizCellSetupDelegate?

    private var tableView: UITableView
    private let isPublicSwitchTag: Int = 0x12
    private let nameTag: Int = 100

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
            placeholder: Text.EditQuiz.namePlaceholder, tag: nameTag
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

    func errorCell(_ cell: ErrorCell, for indexPath: IndexPath) {
        cell.configure(with: messageAboutError)
        cell.delegate = self
    }
}

// MARK: - Action handlers

extension CreateQuizCellSetup: ErrorCellDelegate, UITextFieldDelegate,
    SwitchCellDelegate, QuestionCellDelegate
{
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
        if textField.tag == nameTag {
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
