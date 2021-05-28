//
//  GenericTableViewDataSource.swift
//  General
//
//  Created by Artur Krasnyh on 15/08/2019.
//

import UIKit

protocol GenericTableViewDataSourceDelegate: AnyObject {
    func moveRowAt(sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func deleteRowAt(indexPath: IndexPath)
}

class GenericTableViewDataSource: NSObject, UITableViewDataSource {
    private weak var dataStorage: GenericTableViewDataStorage?

    weak var delegate: GenericTableViewDataSourceDelegate?

    init(with dataStorage: GenericTableViewDataStorage?) {
        self.dataStorage = dataStorage
    }

    // MARK: - Displaying data

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let dataStorage = dataStorage else {
            return 0
        }
        return dataStorage.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataStorage = dataStorage else {
            return 0
        }
        return dataStorage[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataStorage = dataStorage {
            return dataStorage[indexPath].cellFor(tableView, at: indexPath)
        } else {
            return UITableViewCell()
        }
    }

    // MARK: - Manipulating data

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            delegate?.deleteRowAt(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return dataStorage?[indexPath].canMoveRow() ?? false
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let dataStorage = dataStorage {
            let row = dataStorage[indexPath]
            return row.canMoveRow() || row.canDeleteRow()
        } else {
            return false
        }
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        delegate?.moveRowAt(sourceIndexPath: sourceIndexPath, to: destinationIndexPath)
    }
}
