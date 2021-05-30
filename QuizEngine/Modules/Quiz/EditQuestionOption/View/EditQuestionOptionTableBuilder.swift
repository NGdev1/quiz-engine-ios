//
//  EditQuestionOptionTableBuilder.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

final class EditQuestionOptionTableBuilder {
    typealias Row = GenericTableViewRowModel

    // MARK: - Properties

    private var genericDataSource: GenericTableViewDataSource
    // swiftlint:disable weak_delegate
    private var genericTableViewDelegate: GenericTableViewDelegate?
    private var dataStorage: GenericTableViewDataStorage = GenericTableViewDataStorage()
    private var tableView: UITableView
    private var cellsSetup: EditQuestionOptionCellSetup
    private var entity: QuestionOption?

    // MARK: - Init

    init(tableView: UITableView, entity: QuestionOption?) {
        self.entity = entity
        self.tableView = tableView
        self.genericDataSource = GenericTableViewDataSource(with: dataStorage)
        self.genericTableViewDelegate = GenericTableViewDelegate(with: dataStorage)
        tableView.dataSource = genericDataSource
        tableView.delegate = genericTableViewDelegate
        self.cellsSetup = EditQuestionOptionCellSetup(entity: entity, tableView: tableView)
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: EditQuestionOptionCellSetupDelegate) {
        cellsSetup.delegate = delegate
    }

    func showLoading() {
        buildLoadingTableStructure()
        reloadData(animated: true)
    }

    func showError(message: String) {
        cellsSetup.messageAboutError = message
        buildErrorCellTableStructure()
        reloadData(animated: false)
    }

    func updateQuestionOption(_ entity: QuestionOption, animated: Bool) {
        self.entity = entity
        cellsSetup.updateQuestionOption(entity)
        buildFullTableStructure()
        reloadData(animated: animated)
    }

    // MARK: - Private methods

    private func reloadData(animated: Bool) {
        if animated == false { tableView.reloadData(); return }
        if genericDataSource.numberOfSections(in: tableView) == tableView.numberOfSections {
            let range = NSRange(location: 0, length: tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            tableView.reloadSections(sections as IndexSet, with: .fade)
        } else {
            UIView.transition(
                with: tableView,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: { [weak self] in
                    self?.tableView.reloadData()
                },
                completion: nil
            )
        }
    }

    private func buildErrorCellTableStructure() {
        let rowsSequence: [Row] = [
            Row(cellsSetup.errorCell(_:for:), fromNib: true),
        ]
        setRowsSequenceToDataStorage(rowsSequence: rowsSequence)
    }

    private func buildLoadingTableStructure() {
        let rowsSequence: [Row] = [
            Row(LoadingCell.loadingCell(_:for:)),
        ]
        setRowsSequenceToDataStorage(rowsSequence: rowsSequence)
    }

    private func buildFullTableStructure() {
        let rowsSequence: [Row] = [
            Row(cellsSetup.textCell(_:for:)),
            Row(cellsSetup.isCorrectCell(_:for:), fromNib: true, bundle: resourcesBundle),
        ]
        setRowsSequenceToDataStorage(rowsSequence: rowsSequence)
    }

    private func setRowsSequenceToDataStorage(rowsSequence: [GenericTableViewRowModel]) {
        let section = GenericTableViewSectionModel(with: rowsSequence)
        dataStorage.update(withOneSection: section)
        dataStorage.registerFor(tableView)
    }
}
