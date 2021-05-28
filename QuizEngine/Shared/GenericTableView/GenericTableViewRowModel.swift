//
//  BuilderTableRow.swift
//  General
//
//  Created by Artur Krasnyh on 15/08/2019.
//

import UIKit

class GenericTableViewRowModel {
    typealias ConfigurationBlock = ((UITableViewCell, IndexPath) -> Void)
    typealias ActionBlock = (() -> Void)

    // MARK: - Propertioes

    private var configurationBlock: ConfigurationBlock
    private var actionBlock: ActionBlock?
    private var cellType: UITableViewCell.Type

    private weak var cell: UITableViewCell?
    private var indexPath: IndexPath?
    private var fromNib: Bool
    private var canDelete: Bool
    private var canMove: Bool
    private var bundle: Bundle?

    // MARK: - Init

    init<T: UITableViewCell>(
        _ setupCell: ((T, IndexPath) -> Void)?,
        andAction actionBlock: ActionBlock? = nil,
        fromNib: Bool = false,
        canDelete: Bool = false,
        canMove: Bool = false,
        bundle: Bundle? = nil
    ) {
        self.cellType = T.self
        self.fromNib = fromNib
        self.canMove = canMove
        self.canDelete = canDelete
        self.bundle = bundle
        self.configurationBlock = { cell, indexPath in
            guard let cell = cell as? T else { return }
            setupCell?(cell, indexPath)
        }
        self.actionBlock = actionBlock
    }

    // MARK: - Internal methods

    func registerFor(_ tableView: UITableView) {
        if fromNib {
            let nib: UINib
            if let bundle: Bundle = bundle {
                nib = UINib(nibName: cellType.identifier, bundle: bundle)
            } else {
                nib = cellType.nib
            }
            tableView.register(nib, forCellReuseIdentifier: cellType.identifier)
        } else {
            tableView.register(cellType.self, forCellReuseIdentifier: cellType.identifier)
        }
    }

    func cellFor(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = provideCellFor(tableView, at: indexPath)

        configurationBlock(cell, indexPath)
        self.cell = cell
        self.indexPath = indexPath
        return cell
    }

    func didSelectFor(tableView: UITableView, at indexPath: IndexPath) {
        actionBlock?()
    }

    func setActionBlock(_ actionBlock: ActionBlock?) {
        self.actionBlock = actionBlock
    }

    func provideCellFor(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
    }

    func updateCell() {
        guard let cell = self.cell,
              let indexPath = self.indexPath
        else {
            return
        }
        configurationBlock(cell, indexPath)
    }

    func canMoveRow() -> Bool { canMove }

    func canDeleteRow() -> Bool { canDelete }
}
