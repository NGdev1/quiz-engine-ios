//
//  MapObject.swift
//  Map
//
//  Created by Михаил Андреичев on 30.11.2019.
//

import UIKit

public struct MapObject {
    public init(location: Location, image: UIImage, userData: Any? = nil) {
        self.location = location
        self.image = image
        self.userData = userData
    }

    public let location: Location
    public let image: UIImage
    public let userData: Any?
}
