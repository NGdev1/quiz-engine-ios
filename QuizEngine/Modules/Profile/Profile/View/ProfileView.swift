//
//  ProfileView.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

final class ProfileView: UIView {
    // MARK: - Properties

    private var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = tableView.contentInset.with(bottom: 50)
        return tableView
    }()

    private var tableBuilder: ProfileTableBuilder?

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

    private func initData(with entity: Profile? = nil) {
        tableBuilder = ProfileTableBuilder(
            tableView: tableView,
            entity: entity
        )
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: ProfileCellSetupDelegate) {
        tableBuilder?.setDelegate(delegate)
    }

    func showLoading() {
        tableBuilder?.showLoading()
    }

    func updateAppearance(with entity: Profile, animated: Bool = true) {
        tableBuilder?.updateProfile(entity, animated: animated)
    }

    func showError(message: String) {
        tableBuilder?.showError(message: message)
    }
}
