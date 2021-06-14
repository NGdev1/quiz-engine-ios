//
//  YandexMapExtensions.swift
//  Map
//
//  Created by Михаил Андреичев on 22.11.2019.
//

import YandexMapsMobile

public extension YMKPoint {
    var location: Location {
        return Location(latitude: latitude, longitude: longitude)
    }
}

public extension Location {
    var ymkPoint: YMKPoint {
        return YMKPoint(latitude: latitude, longitude: longitude)
    }
}
