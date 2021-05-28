//
//  CreateQuizTableBuilder.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

final class CreateQuizTableBuilder {
    typealias Row = GenericTableViewRowModel

    // MARK: - Properties

    private var genericDataSource: GenericTableViewDataSource
    // swiftlint:disable weak_delegate
    private var genericTableViewDelegate: GenericTableViewDelegate?
    private var dataStorage: GenericTableViewDataStorage = GenericTableViewDataStorage()
    private var tableView: UITableView
    private var cellsSetup: CreateQuizCellSetup
    var entity: Quiz?

    // Action handlers properties
    var delegate: CreateQuizCellSetupDelegate? {
        set {
            cellsSetup.delegate = newValue
        }
        get {
            return cellsSetup.delegate
        }
    }

    var messageAboutError: String {
        set {
            cellsSetup.messageAboutError = newValue
        }
        get {
            return cellsSetup.messageAboutError
        }
    }

    // MARK: - Init

    init(tableView: UITableView, entity: Quiz?) {
        self.entity = entity
        self.tableView = tableView
        self.genericDataSource = GenericTableViewDataSource(with: dataStorage)
        self.genericTableViewDelegate = GenericTableViewDelegate(with: dataStorage)
        tableView.dataSource = genericDataSource
        tableView.delegate = genericTableViewDelegate
        self.cellsSetup = CreateQuizCellSetup(entity: entity, tableView: tableView)
        buildMinimalTableStructure()
    }

    // MARK: - Internal methods

    func showError() {
        buildErrorCellTableStructure()
        reloadData(animated: false)
    }

    func updateQuiz(_ entity: Quiz, animated: Bool) {
        cellsSetup.updateQuiz(entity)
        buildFullTableStructure()
        reloadData(animated: animated)
    }

    func reloadData(animated: Bool) {
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

    // MARK: - Private methods

    private func buildErrorCellTableStructure() {
        let rowsSequence: [Row] = [
            Row(cellsSetup.errorCell(_:for:), fromNib: true),
        ]
        setRowsSequenceToDataStorage(rowsSequence: rowsSequence)
    }

    private func buildMinimalTableStructure() {
        let rowsSequence: [Row] = [
            Row(LoadingCell.loadingCell(_:for:)),
        ]
        setRowsSequenceToDataStorage(rowsSequence: rowsSequence)
    }

    private func buildFullTableStructure() {
        let rowsSequence: [Row] = [
            Row(cellsSetup.someCell(_:for:)),
            Row(cellsSetup.otherCell(_:for:)),
        ]
        setRowsSequenceToDataStorage(rowsSequence: rowsSequence)
    }

    private func setRowsSequenceToDataStorage(rowsSequence: [GenericTableViewRowModel]) {
        let section = GenericTableViewSectionModel(with: rowsSequence)
        dataStorage.update(withOneSection: section)
        dataStorage.registerFor(tableView)
    }
}
