//
//  PublicQuizView.swift
//  QuizEngine
//
//  Created by Admin on 02.06.2021.
//

import MDFoundation

final class PublicQuizView: UIView {
    // MARK: - Properties

    var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInset = tableView.contentInset.with(bottom: 50)
        return tableView
    }()

    private var tableBuilder: PublicQuizTableBuilder?

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
        tableView.refreshControl = UIRefreshControl()
        tableView.backgroundColor = Assets.background1.color
    }

    private func addSubviews() {
        addSubview(tableView)
    }

    private func makeConstraints() {
        tableView.makeEdgesEqualToSuperview()
    }

    private func initData(with entity: Quiz? = nil) {
        tableBuilder = PublicQuizTableBuilder(
            tableView: tableView,
            entity: entity
        )
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: PublicQuizCellSetupDelegate) {
        tableBuilder?.setDelegate(delegate)
    }

    func showLoading(entity: Quiz) {
        tableBuilder?.showLoading(entity: entity)
    }

    func updateAppearance(with entity: Quiz, animated: Bool = true) {
        tableBuilder?.updateQuiz(entity, animated: animated)
    }

    func showError(message: String) {
        tableBuilder?.showError(message: message)
    }
}
