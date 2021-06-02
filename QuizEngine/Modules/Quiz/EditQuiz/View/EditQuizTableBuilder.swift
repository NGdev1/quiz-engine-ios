//
//  EditQuizTableBuilder.swift
//  QuizEngine
//
//  Created by Admin on 28.05.2021.
//

import UIKit

final class EditQuizTableBuilder {
    typealias Row = GenericTableViewRowModel

    // MARK: - Properties

    private var genericDataSource: GenericTableViewDataSource
    // swiftlint:disable weak_delegate
    private var genericTableViewDelegate: GenericTableViewDelegate?
    private var dataStorage: GenericTableViewDataStorage = GenericTableViewDataStorage()
    private var tableView: UITableView
    private var cellsSetup: EditQuizCellSetup
    private var entity: Quiz?

    // MARK: - Init

    init(tableView: UITableView, entity: Quiz?) {
        self.entity = entity
        self.tableView = tableView
        self.genericDataSource = GenericTableViewDataSource(with: dataStorage)
        self.genericTableViewDelegate = GenericTableViewDelegate(with: dataStorage)
        tableView.dataSource = genericDataSource
        tableView.delegate = genericTableViewDelegate
        self.cellsSetup = EditQuizCellSetup(entity: entity, tableView: tableView)
        genericDataSource.delegate = self
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: EditQuizCellSetupDelegate) {
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

    func updateQuiz(_ entity: Quiz, animated: Bool) {
        self.entity = entity
        cellsSetup.updateQuiz(entity)
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
        var rowsSequence: [Row] = [
            Row(cellsSetup.nameCell(_:for:)),
            Row(cellsSetup.descriptionCell(_:for:)),
            Row(cellsSetup.isPublicQuizCell(_:for:), fromNib: true, bundle: resourcesBundle),
            Row(cellsSetup.questionsTitle(_:for:), fromNib: true, bundle: resourcesBundle),
        ]
        cellsSetup.firstQuestionIndexPath = rowsSequence.count
        for _ in entity?.questions ?? [] {
            rowsSequence.append(Row(cellsSetup.questionCell(_:for:), fromNib: true, canDelete: true, bundle: resourcesBundle))
        }
        rowsSequence.append(Row(cellsSetup.addQuestonCell(_:for:), fromNib: true, bundle: resourcesBundle))
        setRowsSequenceToDataStorage(rowsSequence: rowsSequence)
    }

    private func setRowsSequenceToDataStorage(rowsSequence: [GenericTableViewRowModel]) {
        let section = GenericTableViewSectionModel(with: rowsSequence)
        dataStorage.update(withOneSection: section)
        dataStorage.registerFor(tableView)
    }
}

// MARK: - GenericTableViewDataSourceDelegate

extension EditQuizTableBuilder: GenericTableViewDataSourceDelegate {
    func moveRowAt(sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}

    func deleteRowAt(indexPath: IndexPath) {
        let index = indexPath.row - cellsSetup.firstQuestionIndexPath
        entity?.questions.remove(at: index)
        buildFullTableStructure()
    }
}
