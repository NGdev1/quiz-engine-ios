//
//  EntitySearchView.swift
//  QuizEngine
//
//  Created by Admin on 09.06.2021.
//

import UIKit

final class EntitySearchView: UIView {
    
    struct Appearance {}

    // MARK: - Properties

    // MARK: - Init

    override init(frame: CGRect = UIScreen.main.bounds) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {}

    private func addSubviews() {}

    private func makeConstraints() {}

    // MARK: - Internal methods
}
