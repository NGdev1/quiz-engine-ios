//
//  EditQuestionView.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import MDFoundation

final class EditQuestionView: UIView {
    // MARK: - Properties

    private var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = tableView.contentInset.with(bottom: 50)
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 50, right: 0)
        return tableView
    }()

    private var tableBuilder: EditQuestionTableBuilder?

    static let textTag: Int = 100

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
        addActionHandlers()
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

    private func initData(with entity: Question? = nil) {
        tableBuilder = EditQuestionTableBuilder(
            tableView: tableView,
            entity: entity
        )
    }

    // MARK: - Action handlers

    private func addActionHandlers() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        addGestureRecognizer(tapRecognizer)
    }

    @objc
    private func viewDidTap() {
        endEditing(true)
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: EditQuestionCellSetupDelegate) {
        tableBuilder?.setDelegate(delegate)
    }

    func showLoading() {
        tableBuilder?.showLoading()
    }

    func updateAppearance(with entity: Question, animated: Bool = true) {
        tableBuilder?.updateQuestion(entity, animated: animated)
    }

    func showError(message: String) {
        tableBuilder?.showError(message: message)
    }
}
