//
//  HistoryDataSource.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

import UIKit

protocol HistoryDataSourceDelegate: AnyObject {
    func didSelectQuizPassing(_ item: QuizPassing)
    func actionButtonTapped()
}

final class HistoryDataSource: NSObject {
    // MARK: - Properties

    enum State {
        case loading
        case presentingList
        case noContent
        case error
    }

    private var data: [QuizPassing] = []
    private var tableView: UITableView?

    weak var delegate: HistoryDataSourceDelegate?

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
            HistoryItemCell.nib,
            forCellReuseIdentifier: HistoryItemCell.identifier
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

    func updateData(_ data: [QuizPassing]) {
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

extension HistoryDataSource: UITableViewDataSource {
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
            cell?.configure(text: Text.History.noContent)
            return cell ?? UITableViewCell()
        case .presentingList:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HistoryItemCell.identifier,
                for: indexPath
            ) as? HistoryItemCell
            let item = data[indexPath.row]
            cell?.configure(historyItem: item)
            return cell ?? UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension HistoryDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if state == .presentingList, indexPath.row < data.count {
            let item = data[indexPath.row]
            delegate?.didSelectQuizPassing(item)
        }
    }
}

// MARK: - Action handlers

extension HistoryDataSource: ErrorCellDelegate {
    func reloadData() {
        delegate?.actionButtonTapped()
    }
}
