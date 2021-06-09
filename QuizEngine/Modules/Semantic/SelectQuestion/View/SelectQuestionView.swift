//
//  SelectQuestionView.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import MDFoundation

final class SelectQuestionView: UITableView {
    // MARK: - Properties

    private var customDataSource: TriplesDataSource = TriplesDataSource()

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
        tableFooterView = UIView()
        rowHeight = UITableView.automaticDimension
        separatorInset = .zero
        contentInset.bottom = 40
        contentInsetAdjustmentBehavior = .always
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: TriplesDataSourceDelegate) {
        customDataSource.delegate = delegate
    }

    func showError(message: String) {
        customDataSource.errorMessage = message
        customDataSource.state = .error
    }

    func showLoading() {
        customDataSource.state = .loading
    }

    func updateTriples(_ data: [Triple]) {
        customDataSource.updateData(data)
    }
}
