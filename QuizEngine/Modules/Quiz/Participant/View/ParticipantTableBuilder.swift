//
//  ParticipantTableBuilder.swift
//  QuizEngine
//
//  Created by Admin on 08.06.2021.
//

import UIKit

final class ParticipantTableBuilder {
    typealias Row = GenericTableViewRowModel

    // MARK: - Properties

    private var genericDataSource: GenericTableViewDataSource
    // swiftlint:disable weak_delegate
    private var genericTableViewDelegate: GenericTableViewDelegate?
    private var dataStorage: GenericTableViewDataStorage = GenericTableViewDataStorage()
    private var tableView: UITableView
    private var cellsSetup: ParticipantCellSetup
    private var entity: ParticipantResults?

    // MARK: - Init

    init(tableView: UITableView, entity: ParticipantResults?) {
        self.entity = entity
        self.tableView = tableView
        self.genericDataSource = GenericTableViewDataSource(with: dataStorage)
        self.genericTableViewDelegate = GenericTableViewDelegate(with: dataStorage)
        tableView.dataSource = genericDataSource
        tableView.delegate = genericTableViewDelegate
        self.cellsSetup = ParticipantCellSetup(entity: entity, tableView: tableView)
    }

    // MARK: - Internal methods

    func setDelegate(_ delegate: ParticipantCellSetupDelegate) {
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

    func updateParticipant(_ entity: ParticipantResults, animated: Bool) {
        self.entity = entity
        cellsSetup.updateParticipant(entity)
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
            Row(cellsSetup.profileHeaderCell(_:for:), fromNib: true, bundle: resourcesBundle),
            Row(cellsSetup.pirsonValueCell(_:for:)),
            Row(cellsSetup.spirmenBrownCell(_:for:)),
            Row(cellsSetup.resultsHeaderCell(_:for:), fromNib: true, bundle: resourcesBundle),
        ]
        cellsSetup.firstIndexPath = rowsSequence.count
        for _ in entity?.results ?? [] {
            rowsSequence.append(
                Row(cellsSetup.quizPassingCell(_:for:), fromNib: true, bundle: resourcesBundle)
            )
        }
        setRowsSequenceToDataStorage(rowsSequence: rowsSequence)
    }

    private func setRowsSequenceToDataStorage(rowsSequence: [GenericTableViewRowModel]) {
        let section = GenericTableViewSectionModel(with: rowsSequence)
        dataStorage.update(withOneSection: section)
        dataStorage.registerFor(tableView)
    }
}
