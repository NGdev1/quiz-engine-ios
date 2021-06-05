//
//  QuestionOptionsDataSource.swift
//  QuizEngine
//
//  Created by Admin on 05.06.2021.
//

import UIKit

protocol QuestionOptionsDataSourceDelegate: AnyObject {
    func didSelectOption()
    func actionButtonTapped()
}

final class QuestionOptionsDataSource: NSObject {
    // MARK: - Properties

    enum State {
        case loading
        case presentingList
        case error
    }

    var selectedIndex: Int?
    private var question: Question?
    private var tableView: UITableView?

    weak var delegate: QuestionOptionsDataSourceDelegate?

    var errorMessage: String?
    var state: State = .loading {
        didSet {
            reloadData(animated: true)
        }
    }

    // MARK: - Internal methods

    func setTableView(_ tableView: UITableView) {
        self.tableView = tableView
        tableView.register(
            QuestionContentView.self,
            forHeaderFooterViewReuseIdentifier: QuestionContentView.identifier
        )
        tableView.register(
            OptionRadioCell.nib,
            forCellReuseIdentifier: OptionRadioCell.identifier
        )
        tableView.register(
            ErrorCell.nib,
            forCellReuseIdentifier: ErrorCell.identifier
        )
        tableView.register(
            LoadingCell.self,
            forCellReuseIdentifier: LoadingCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
    }

    func updateData(_ question: Question?) {
        self.question = question
        state = .presentingList
    }

    func getSelectedOption() -> QuestionOption? {
        guard let selectedIndex = selectedIndex else { return nil }
        return question?.options[selectedIndex]
    }

    // MARK: - Private methods

    func reloadData(animated: Bool) {
        if animated {
            let range = NSRange(location: 0, length: 1)
            let sections = NSIndexSet(indexesIn: range)
            tableView?.reloadSections(sections as IndexSet, with: .fade)
        } else {
            tableView?.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension QuestionOptionsDataSource: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state == .presentingList {
            return question?.options.count ?? 0
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: QuestionContentView.identifier
        ) as? QuestionContentView else { return nil }
        view.configure(text: question?.text)
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .loading:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LoadingCell.identifier,
                for: indexPath
            ) as? LoadingCell
            cell?.configure()
            return cell ?? UITableViewCell()
        case .error:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ErrorCell.identifier,
                for: indexPath
            ) as? ErrorCell
            cell?.delegate = self
            cell?.configure(with: errorMessage ?? .empty)
            return cell ?? UITableViewCell()
        case .presentingList:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OptionRadioCell.identifier,
                for: indexPath
            ) as? OptionRadioCell
            if let item = question?.options[indexPath.row] {
                cell?.configure(option: item, isSelected: indexPath.row == selectedIndex)
            }
            return cell ?? UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension QuestionOptionsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if state == .presentingList {
            var indexPaths: [IndexPath] = [indexPath]
            if let selectedIndex = selectedIndex {
                indexPaths.append(IndexPath(row: selectedIndex, section: 0))
            }
            selectedIndex = indexPath.row
            tableView.reloadRows(at: indexPaths, with: .automatic)
            delegate?.didSelectOption()
        }
    }
}

// MARK: - Action handlers

extension QuestionOptionsDataSource: ErrorCellDelegate {
    func reloadData() {
        delegate?.actionButtonTapped()
    }
}
