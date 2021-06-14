//
//  MapAppearance.swift
//  Map
//
//  Created by Михаил Андреичев on 30.11.2019.
//

protocol MapAppearance {
    var defaultLocation: Location { get }
}

extension MapAppearance {
    var defaultLocation: Location { return Location(latitude: 55.751244, longitude: 37.618423) }
}
