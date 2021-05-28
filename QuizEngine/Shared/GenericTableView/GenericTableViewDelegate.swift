//
//  GenericTableViewDelegate.swift
//  General
//
//  Created by Artur Krasnyh on 15/08/2019.
//

import Foundation
import UIKit

class GenericTableViewDelegate: NSObject, UITableViewDelegate {
    private weak var dataStorage: GenericTableViewDataStorage?

    var contentOffsetChangedBlock: ((CGPoint) -> Void)?

    init(with dataStorage: GenericTableViewDataStorage) {
        self.dataStorage = dataStorage
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataStorage = self.dataStorage {
            dataStorage[indexPath].didSelectFor(tableView: tableView, at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let dataStorage = dataStorage else { return CGFloat.leastNonzeroMagnitude }
        let sectionModel: GenericTableViewSectionModel = dataStorage[section]
        if sectionModel.footerProvider == nil {
            return CGFloat.leastNonzeroMagnitude
        } else {
            return tableView.sectionFooterHeight
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let provider = dataStorage?[section].footerProvider else { return UIView() }
        return provider(tableView, section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if dataStorage?[section].headerProvider == nil {
            return 0
        } else {
            return tableView.sectionHeaderHeight
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let provider = dataStorage?[section].headerProvider else {
            return nil
        }
        return provider(tableView, section)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let provider = dataStorage?.paginationProvider, let dataStorage = dataStorage else {
            return
        }

        let isLastSection = indexPath.section == dataStorage.count - 1
        let isLastCellInSection = indexPath.row == dataStorage[indexPath.section].count - 1

        if isLastSection, isLastCellInSection {
            provider()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetChangedBlock?(scrollView.contentOffset)
    }
}
