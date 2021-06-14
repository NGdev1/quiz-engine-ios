//
//  MapFactory.swift
//  Map
//
//  Created by Михаил Андреичев on 30.11.2019.
//

public class MapFactory {
    private init() {}

    public static let shared = MapFactory()

    public var mapView: MapViewProtocol { YandexMapView() }
    public lazy var apiKeyManager: MapApiKeyProtocol = YandexApiKey()
}
