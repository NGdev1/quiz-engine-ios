//
//  CreateQuizView.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

final class CreateQuizView: UIView {
    // MARK: - Properties

    var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = tableView.contentInset.with(bottom: 50)
        return tableView
    }()

    var tableBuilder: CreateQuizTableBuilder?

    // MARK: - Init

    override init(frame: CGRect = UIScreen.main.bounds) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
        initData()
    }

    private func setupStyle() {
        tableView.backgroundColor = Assets.background1.color
    }

    private func addSubviews() {
        addSubview(tableView)
    }

    private func makeConstraints() {
        tableView.makeEdgesEqualToSuperview()
    }

    private func initData(with entity: Quiz? = nil) {
        tableBuilder = CreateQuizTableBuilder(
            tableView: tableView,
            entity: entity
        )
    }

    // MARK: - Internal methods

    func updateAppearance(with entity: Quiz, animated: Bool = true) {
        tableBuilder?.updateQuiz(entity, animated: animated)
    }

    func showError(message: String) {
        tableBuilder?.messageAboutError = message
        tableBuilder?.showError()
    }
}
