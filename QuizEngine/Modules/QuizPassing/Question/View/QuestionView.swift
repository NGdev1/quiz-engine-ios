//
//  QuestionView.swift
//  QuizEngine
//
//  Created by Admin on 05.06.2021.
//

import MDFoundation

final class QuestionView: UITableView {
    // MARK: - Properties

    private var customDataSource: QuestionOptionsDataSource = QuestionOptionsDataSource()
    lazy var bottomView: FixedBottomView = FixedBottomView(buttonText: Text.Common.next)

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
        estimatedRowHeight = 125
        contentInset.bottom = 100
        contentInsetAdjustmentBehavior = .always
    }

    // MARK: - Internal methods

    func getSelectedOption() -> QuestionOption? {
        return customDataSource.getSelectedOption()
    }

    func setDelegate(_ delegate: QuestionOptionsDataSourceDelegate) {
        customDataSource.delegate = delegate
    }

    func showError(message: String) {
        customDataSource.errorMessage = message
        customDataSource.state = .error
    }

    func showLoading() {
        customDataSource.state = .loading
    }

    func showQuestion(_ question: Question, answer: QuestionAnswer?) {
        customDataSource.selectedIndex = question.options.firstIndex(where: { item in
            guard item.id != nil else { return false }
            return item.id == answer?.option?.id
        })
        bottomView.setEnabled(customDataSource.selectedIndex != nil)
        customDataSource.updateData(question)
    }
}
