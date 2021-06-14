//
//  YandexMap.swift
//  Map
//
//  Created by Михаил Андреичев on 30.11.2019.
//

import YandexMapsMobile

public final class YandexApiKey: MapApiKeyProtocol {
    public func setApiKey() {
        YMKMapKit.setApiKey("2c485d68-7fb9-48b0-91a8-d708727db72e")
    }
}
