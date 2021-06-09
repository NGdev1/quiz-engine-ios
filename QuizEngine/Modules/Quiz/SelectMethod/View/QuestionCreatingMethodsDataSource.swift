//
//  QuestionCreatingMethodsDataSource.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import UIKit

protocol QuestionCreatingMethodsDataSourceDelegate: AnyObject {
    func didSelectQuestionCreatingMethod(_ item: QuestionCreatingMethod)
}

final class QuestionCreatingMethodsDataSource: NSObject {
    // MARK: - Properties

    private var data: [QuestionCreatingMethod] = QuestionCreatingMethod.all
    private var tableView: UITableView?

    weak var delegate: QuestionCreatingMethodsDataSourceDelegate?

    // MARK: - Internal methods

    func setTableView(_ tableView: UITableView) {
        self.tableView = tableView
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "QuestionCreatingMethodCell"
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension QuestionCreatingMethodsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "QuestionCreatingMethodCell",
            for: indexPath
        )
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension QuestionCreatingMethodsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        delegate?.didSelectQuestionCreatingMethod(item)
    }
}
