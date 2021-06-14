//
//  SelectRegionView.swift
//  QuizEngine
//
//  Created by Admin on 14.06.2021.
//

import Map
import UIKit

final class SelectRegionView: UIView {
    struct Appearance {}

    // MARK: - Properties

    var mapView: MapViewProtocol = MapFactory.shared.mapView

    lazy var userLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.buttonUserLocation.image, for: .normal)
        button.addShadow()
        return button
    }()

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

    private func setupStyle() {
        backgroundColor = Assets.background1.color
    }

    private func addSubviews() {
        addSubview(mapView)
        addSubview(userLocationButton)
    }

    private func makeConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        userLocationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(mapView).offset(-40)
            make.size.equalTo(48)
        }
    }

    // MARK: - Internal methods

    func moveToPoint(_ point: Location) {
        mapView.moveCameraTo(location: point, animated: true, defaultScale: false)
    }
}
