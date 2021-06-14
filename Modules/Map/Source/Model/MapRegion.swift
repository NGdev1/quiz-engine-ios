//
//  MapRegion.swift
//  GeneralBusinessLogic
//
//  Created by Михаил Андреичев on 26.11.2019.
//

public struct MapRegion {
    public init(
        topLeft: Location,
        bottomRight: Location
    ) {
        self.topLeft = topLeft
        self.bottomRight = bottomRight
    }

    public let topLeft: Location
    public let bottomRight: Location
}
