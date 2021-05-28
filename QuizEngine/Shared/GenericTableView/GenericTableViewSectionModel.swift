//
//  GenericTableViewSectionModel.swift
//  General
//
//  Created by Artur Krasnyh on 15/08/2019.
//

import UIKit

class GenericTableViewSectionModel {
    typealias RowsCollection = [GenericTableViewRowModel]

    private var rows: RowsCollection
    var headerProvider: ((_ tableView: UITableView, _ section: Int) -> UIView?)?
    var footerProvider: ((_ tableView: UITableView, _ section: Int) -> UIView?)?

    init(with rows: RowsCollection) {
        self.rows = rows
    }

    var count: Int {
        return rows.count
    }

    func registerFor(_ tableView: UITableView) {
        for row in rows {
            row.registerFor(tableView)
        }
    }

    subscript(row: IndexPath.Element) -> RowsCollection.Element {
        return rows[row]
    }

    func updateCells() {
        rows.forEach { $0.updateCell() }
    }
}
