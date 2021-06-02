//
//  HomePageDataSource.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

import UIKit

protocol HomePageDataSourceDelegate: AnyObject {
    func didSelectQuiz(_ item: Quiz)
    func actionButtonTapped()
}

final class HomePageDataSource: NSObject {
    // MARK: - Properties

    enum State {
        case loading
        case presentingList
        case noContent
        case error
    }

    private var data: [Quiz] = []
    private var tableView: UITableView?

    weak var delegate: HomePageDataSourceDelegate?

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
            QuizCell.nib,
            forCellReuseIdentifier: QuizCell.identifier
        )
        tableView.register(
            ErrorCell.nib,
            forCellReuseIdentifier: ErrorCell.identifier
        )
        tableView.register(
            NoContentCell.self,
            forCellReuseIdentifier: NoContentCell.identifier
        )
        tableView.register(
            LoadingCell.self,
            forCellReuseIdentifier: LoadingCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
    }

    func updateData(_ data: [Quiz]) {
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

extension HomePageDataSource: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                withIdentifier: NoContentCell.identifier,
                for: indexPath
            ) as? NoContentCell
            cell?.configure(text: Text.QuizList.noContent)
            return cell ?? UITableViewCell()
        case .presentingList:
            if indexPath.row < data.count {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: QuizCell.identifier,
                    for: indexPath
                ) as? QuizCell
                let item = data[indexPath.row]
                cell?.configure(item)
                return cell ?? UITableViewCell()
            } else {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: LoadingCell.identifier,
                    for: indexPath
                ) as? LoadingCell

                cell?.configure(height: 50)
                return cell ?? UITableViewCell()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension HomePageDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if state == .presentingList, indexPath.row < data.count {
            let item = data[indexPath.row]
            delegate?.didSelectQuiz(item)
        }
    }
}

// MARK: - Action handlers

extension HomePageDataSource: ErrorCellDelegate {
    func reloadData() {
        delegate?.actionButtonTapped()
    }
}
