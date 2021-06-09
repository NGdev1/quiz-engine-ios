//
//  EntitiesDataSource.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import UIKit

protocol EntitiesDataSourceDelegate: AnyObject {
    func didSelectEntity(_ item: Entity)
    func actionButtonTapped()
}

final class EntitiesDataSource: NSObject {
    // MARK: - Properties

    enum State {
        case loading
        case presentingList
        case noContent
        case error
    }

    private var data: [Entity] = []
    private var tableView: UITableView?

    weak var delegate: EntitiesDataSourceDelegate?

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
            UITableViewCell.self,
            forCellReuseIdentifier: "EntityCell"
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

    func updateData(_ data: [Entity]) {
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

extension EntitiesDataSource: UITableViewDataSource {
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
            cell?.configure(text: Text.SelectEntity.noContent)
            return cell ?? UITableViewCell()
        case .presentingList:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "EntityCell",
                for: indexPath
            )
            let item = data[indexPath.row]
            cell.textLabel?.text = item.label
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension EntitiesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if state == .presentingList {
            let item = data[indexPath.row]
            delegate?.didSelectEntity(item)
        }
    }
}

// MARK: - Action handlers

extension EntitiesDataSource: ErrorCellDelegate {
    func reloadData() {
        delegate?.actionButtonTapped()
    }
}
