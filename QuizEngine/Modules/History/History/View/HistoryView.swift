//
//  HistoryView.swift
//  QuizEngine
//
//  Created by Admin on 07.06.2021.
//

import MDFoundation

final class HistoryView: UITableView {
    // MARK: - Properties

    private var customDataSource: HistoryDataSource = HistoryDataSource()

    // MARK: - Init

    override init(frame: CGRect = UIScreen.main.bounds, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)
        setupStyle()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle() {
        customDataSource.setTableView(self)
        backgroundColor = Assets.background1.color
        refreshControl = UIRefreshControl()
        tableFooterView = UIView()
        rowHeight = UITableView.automaticDimension
        separatorInset = .zero
        estimatedRowHeight = 125
        contentInset.bottom = 100
        contentInsetAdjustmentBehavior = .always
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: HistoryDataSourceDelegate) {
        customDataSource.delegate = delegate
    }

    func endRefreshing() {
        refreshControl?.endRefreshing()
    }

    func showError(message: String) {
        customDataSource.errorMessage = message
        customDataSource.state = .error
    }

    func showLoading() {
        customDataSource.state = .loading
    }

    func updateQuizPassings(_ data: [QuizPassing]) {
        customDataSource.updateData(data)
    }
}
