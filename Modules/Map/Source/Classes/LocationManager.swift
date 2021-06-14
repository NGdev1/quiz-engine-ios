//
//  LocationManager.swift
//  Map
//
//  Created by Михаил Андреичев on 21.11.2019.
//

import MapKit

public protocol LocationManagerDelegate: AnyObject {
    func userLocationUpdated(_ location: Location)
    func userAsksLocationButDidNotAllow()
}

public final class LocationManager: NSObject {
    // MARK: - Properties

    private var locationManager = CLLocationManager()
    private var userLocation: CLLocation?
    private var currentStatus: CLAuthorizationStatus = .notDetermined

    public static let sharedInstance = LocationManager()

    public weak var delegate: LocationManagerDelegate?

    /// Возвращает координаты пользователя.
    /// Если их нет (пользователь не дал доступ) - возвращает nil.
    public var userCoordinates: Location? {
        guard
            let longitude = userLocation?.coordinate.longitude,
            let latitude = userLocation?.coordinate.latitude
        else { return nil }
        return Location(latitude: latitude, longitude: longitude)
    }

    // MARK: - Init

    override private init() {
        super.init()
        locationManager.delegate = self
    }

    // MARK: - Public methods

    public func updateLocation() {
        if currentStatus == .denied {
            delegate?.userAsksLocationButDidNotAllow()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        locationManager.stopUpdatingLocation()
        guard let userLocation: CLLocation = locations.last else { return }
        self.userLocation = userLocation
        let location = Location(
            latitude: userLocation.coordinate.latitude,
            longitude: userLocation.coordinate.longitude
        )
        delegate?.userLocationUpdated(location)
    }

    public func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        currentStatus = status
        userLocation = nil
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

// MARK: - CLLocationCoordinate2D - Location

public extension CLLocationCoordinate2D {
    var location: Location {
        return Location(latitude: latitude, longitude: longitude)
    }
}
