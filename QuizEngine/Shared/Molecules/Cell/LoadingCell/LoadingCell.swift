//
//  LoadingCell.swift
//  MD
//
//  Created by Михаил Андреичев on 11/09/2019.
//  Copyright © 2019 MD. All rights reserved.
//

import MDFoundation
import SnapKit

final class LoadingCell: UITableViewCell {
    // MARK: - Init

    lazy var loadingIndicator: UIActivityIndicatorView = {
        if #available(iOS 13, *) {
            return UIActivityIndicatorView(style: .large)
        } else {
            return UIActivityIndicatorView(style: .gray)
        }
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    // MARK: - Private methods

    private func setupStyle() {
        selectionStyle = .none
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(
            top: 0, left: UIScreen.main.bounds.width,
            bottom: 0, right: 0
        )
    }

    private func addSubviews() {
        contentView.addSubview(loadingIndicator)
    }

    private func makeConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
    }

    // MARK: - Public methods

    func configure(height: CGFloat? = nil) {
        loadingIndicator.startAnimating()
        if let height = height {
            loadingIndicator.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
    }

    // MARK: - Generic table view configure cell method

    static func loadingCell(_ cell: LoadingCell, for indexPath: IndexPath) {
        cell.loadingIndicator.startAnimating()
    }

    static func smallLoadingCell(_ cell: LoadingCell, for indexPath: IndexPath) {
        cell.loadingIndicator.startAnimating()
        cell.loadingIndicator.snp.updateConstraints { make in
            make.height.equalTo(50)
        }
    }
}
