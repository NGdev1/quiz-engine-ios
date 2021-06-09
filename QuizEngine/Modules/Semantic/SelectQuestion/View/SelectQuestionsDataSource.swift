//
//  SelectQuestionsDataSource.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import UIKit

protocol TriplesDataSourceDelegate: AnyObject {
    func didSelectTriple(_ item: Triple)
    func actionButtonTapped()
}

final class TriplesDataSource: NSObject {
    // MARK: - Properties

    enum State {
        case loading
        case presentingList
        case noContent
        case error
    }

    private var data: [Triple] = []
    private var tableView: UITableView?

    weak var delegate: TriplesDataSourceDelegate?

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
            TripleQuestionCell.nib,
            forCellReuseIdentifier: TripleQuestionCell.identifier
        )
        tableView.register(
            ErrorCell.nib,
            forCellReuseIdentifier: ErrorCell.identifier
        )
        tableView.register(
            SimpleTextCell.self,
            forCellReuseIdentifier: SimpleTextCell.identifier
        )
        tableView.register(
            LoadingCell.self,
            forCellReuseIdentifier: LoadingCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
    }

    func updateData(_ data: [Triple]) {
        self.data = data
        if data.isEmpty {
            state = .noContent
        } else {
            state = .presentingList
        }
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

extension TriplesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state == .presentingList {
            return data.count
        } else {
            return 1
        }
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
        case .noContent:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SimpleTextCell.identifier,
                for: indexPath
            ) as? SimpleTextCell
            cell?.configure(text: Text.SelectQuestion.noContent)
            return cell ?? UITableViewCell()
        case .presentingList:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TripleQuestionCell.identifier,
                for: indexPath
            ) as? TripleQuestionCell
            let item = data[indexPath.row]
            cell?.configure(triple: item, delegate: self)
            return cell ?? UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension TriplesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if state == .presentingList {
            let item = data[indexPath.row]
            delegate?.didSelectTriple(item)
        }
    }
}

// MARK: - Action handlers

extension TriplesDataSource: ErrorCellDelegate, TripleQuestionCellDelegate {
    func reloadData() {
        delegate?.actionButtonTapped()
    }
}
