//
//  MapViewProtocol.swift
//  Map
//
//  Created by Михаил Андреичев on 30.11.2019.
//

import UIKit

public protocol MapViewDelegate: AnyObject {
    func mapTap(location: Location)
    func mapLongTap(location: Location)
    func objectSelected(_ object: MapObject)
    func regionDidChange(region: MapRegion, center: Location, zoom: Float, byUser: Bool)
    func regionWillChange()
}

public protocol MapViewProtocol where Self: UIView {
    var delegate: MapViewDelegate? { get set }
    var zoom: Float { get }
    var region: MapRegion { get }
    func setObjects(_ objects: [MapObject])
    func zoomIn(to location: Location)
    func moveCateraTo(location: Location, animated: Bool, zoom: Float)
    func moveCameraTo(location: Location, animated: Bool, defaultScale: Bool)
}
