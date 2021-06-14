//
//  YandexMapView.swift
//  matur
//
//  Created by Михаил Андреичев on 31.10.2019.
//  Copyright © 2019 Михаил Андреичев. All rights reserved.
//

import YandexMapsMobile

final class YandexMapView: YMKMapView, MapViewProtocol {
    private struct YandexMapAppearance: MapAppearance {
        let defaultZoom: Float = 14
        let animationDuration: Float = 0.3
        let isRotationEnabled = false
    }

    // MARK: - Properties

    private let appearance = YandexMapAppearance()
    private lazy var map = mapWindow.map
    private lazy var mapObjects = map.mapObjects
    private var mapRegionDidStartChanging: Bool = false
    private var objects: [MapObject]?

    var zoom: Float {
        map.cameraPosition.zoom
    }

    var region: MapRegion {
        MapRegion(
            topLeft: mapWindow.focusRegion.topLeft.location,
            bottomRight: mapWindow.focusRegion.bottomRight.location
        )
    }

    // MARK: - Action properties

    public weak var delegate: MapViewDelegate?

    public var objectSelected: ((MapObject) -> Void)?
    weak var userLocationLayer: YMKUserLocationLayer?

    // MARK: - Init

    override init(frame: CGRect = UIScreen.main.bounds) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        map.logo.setAlignmentWith(YMKLogoAlignment(
            horizontalAlignment: .left,
            verticalAlignment: .bottom
        ))
        map.addCameraListener(with: self)
        map.addInputListener(with: self)
        mapObjects.addTapListener(with: self)
        map.isRotateGesturesEnabled = appearance.isRotationEnabled
        moveCameraTo(location: appearance.defaultLocation, animated: false, defaultScale: true)
        let mapKit = YMKMapKit.sharedInstance()
        userLocationLayer = mapKit.createUserLocationLayer(with: mapWindow)
        userLocationLayer?.setObjectListenerWith(self)
        userLocationLayer?.setVisibleWithOn(true)
        userLocationLayer?.isHeadingEnabled = false
    }

    // MARK: - MapViewProtocol

    public func setObjects(_ objects: [MapObject]) {
        self.objects = objects
        mapObjects.clear()
        for object in objects {
            let currentObject = mapObjects.addPlacemark(
                with: object.location.ymkPoint,
                image: object.image
            )
            currentObject.userData = object
        }
    }

    func zoomIn(to location: Location) {
        let cameraPosition = YMKCameraPosition(
            target: location.ymkPoint,
            zoom: map.cameraPosition.zoom + 2,
            azimuth: map.cameraPosition.azimuth,
            tilt: map.cameraPosition.tilt
        )
        map.move(
            with: cameraPosition,
            animationType: YMKAnimation(
                type: YMKAnimationType.smooth,
                duration: appearance.animationDuration
            )
        )
    }

    func moveCateraTo(location: Location, animated: Bool, zoom: Float) {
        let cameraPosition = YMKCameraPosition(
            target: location.ymkPoint,
            zoom: zoom,
            azimuth: map.cameraPosition.azimuth,
            tilt: map.cameraPosition.tilt
        )
        if animated {
            map.move(
                with: cameraPosition,
                animationType: YMKAnimation(
                    type: YMKAnimationType.smooth,
                    duration: appearance.animationDuration
                )
            )
        } else {
            map.move(with: cameraPosition)
        }
    }

    public func moveCameraTo(location: Location, animated: Bool, defaultScale: Bool) {
        let zoom = defaultScale ? appearance.defaultZoom : map.cameraPosition.zoom
        let azimuth = defaultScale ? 0 : map.cameraPosition.azimuth
        let tilt = defaultScale ? 0 : map.cameraPosition.tilt
        let cameraPosition = YMKCameraPosition(
            target: location.ymkPoint,
            zoom: zoom,
            azimuth: azimuth,
            tilt: tilt
        )
        if animated {
            map.move(
                with: cameraPosition,
                animationType: YMKAnimation(
                    type: YMKAnimationType.smooth,
                    duration: appearance.animationDuration
                )
            )
        } else {
            map.move(with: cameraPosition)
        }
    }
}

// MARK: - YMKMapCameraListener

extension YandexMapView: YMKMapCameraListener {
    public func onCameraPositionChanged(
        with map: YMKMap,
        cameraPosition: YMKCameraPosition,
        cameraUpdateReason: YMKCameraUpdateReason,
        finished: Bool
    ) {
        if finished {
            let ymkRegion = mapWindow.focusRegion
            let region = MapRegion(
                topLeft: ymkRegion.topLeft.location,
                bottomRight: ymkRegion.bottomRight.location
            )
            let center = cameraPosition.target.location
            delegate?.regionDidChange(
                region: region, center: center,
                zoom: cameraPosition.zoom, byUser: cameraUpdateReason == .gestures
            )
            mapRegionDidStartChanging = false
        } else if mapRegionDidStartChanging == false {
            mapRegionDidStartChanging = true
            delegate?.regionWillChange()
        }
    }
}

// MARK: - YMKMapInputListener

extension YandexMapView: YMKMapInputListener {
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        delegate?.mapTap(location: point.location)
    }

    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        delegate?.mapLongTap(location: point.location)
    }
}
