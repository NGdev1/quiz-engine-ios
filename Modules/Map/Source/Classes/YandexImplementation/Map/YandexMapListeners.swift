//
//  YandexMapListeners.swift
//  Map
//
//  Created by Михаил Андреичев on 28.11.2019.
//

import YandexMapsMobile

// MARK: - YMKUserLocationObjectListener

extension YandexMapView: YMKUserLocationObjectListener {
    public func onObjectAdded(with view: YMKUserLocationView) {
        view.accuracyCircle.fillColor = Assets.baseTint1.color.withAlphaComponent(0.3)
        view.pin.setIconWith(Assets.userPin.image)
        view.arrow.setIconWith(Assets.userPin.image)
    }

    public func onObjectRemoved(with view: YMKUserLocationView) {}

    public func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
}

// MARK: - YMKMapObjectTapListener

extension YandexMapView: YMKMapObjectTapListener {
    public func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let object = mapObject.userData as? MapObject else {
            return true
        }
        delegate?.objectSelected(object)
        return true
    }
}
