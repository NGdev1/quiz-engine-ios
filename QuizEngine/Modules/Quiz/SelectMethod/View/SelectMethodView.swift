//
//  SelectMethodView.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import MDFoundation

final class SelectMethodView: UITableView {
    // MARK: - Properties

    private var customDataSource: QuestionCreatingMethodsDataSource = QuestionCreatingMethodsDataSource()

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
        contentInsetAdjustmentBehavior = .always
        contentInset.top = 10
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: QuestionCreatingMethodsDataSourceDelegate) {
        customDataSource.delegate = delegate
    }
}
