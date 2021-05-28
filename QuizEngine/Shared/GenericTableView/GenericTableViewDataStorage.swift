//
//  GenericTableViewDataStorage.swift
//  General
//
//  Created by Artur Krasnyh on 15/08/2019.
//

import Foundation
import UIKit

class GenericTableViewDataStorage {
    typealias SectionCollection = [GenericTableViewSectionModel]
    private var sections: SectionCollection

    var paginationProvider: (() -> Void)?

    private(set) lazy var tableViewDataSource: UITableViewDataSource = {
        let dataSource = GenericTableViewDataSource(with: self)
        return dataSource
    }()

    var count: Int {
        return sections.count
    }

    required init(with sections: SectionCollection) {
        self.sections = sections
    }

    convenience init(withSectionArray sections: [[GenericTableViewRowModel]]) {
        self.init(with: sections.map { GenericTableViewSectionModel(with: $0) })
    }

    convenience init(withOneSection section: GenericTableViewSectionModel) {
        self.init(with: [section])
    }

    convenience init() {
        self.init(withSectionArray: [])
    }

    func registerFor(_ tableView: UITableView) {
        for section in sections {
            section.registerFor(tableView)
        }
    }

    func update(with sections: SectionCollection) {
        self.sections = sections
    }

    func update(withSectionArray sections: [[GenericTableViewRowModel]]) {
        update(with: sections.map { GenericTableViewSectionModel(with: $0) })
    }

    func update(withOneSection section: GenericTableViewSectionModel?) {
        guard let section = section else { return }
        sections = [section]
    }

    func append(section: GenericTableViewSectionModel?) {
        guard let section = section else { return }
        sections.append(section)
    }

    func clear() {
        sections.removeAll()
    }

    subscript(indexPath: IndexPath) -> GenericTableViewRowModel {
        return sections[indexPath.section][indexPath.row]
    }

    subscript(section: Int) -> SectionCollection.Element {
        return sections[section]
    }
}
