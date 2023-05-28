//
//  Location.swift
//  CAFU
//
//  Created by Ahmed Ramy on 06/10/2022.
//

import Configs
import CoreLocation
import Factory
import Foundation

// MARK: - Coordinates

public struct Coordinates {
    public var latitude: Double
    public var longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    public init() {
        latitude = 0.0
        longitude = 0.0
    }
}

// MARK: Equatable

extension Coordinates: Equatable {
    public static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
}

public extension Coordinates {
    static let `default` = Coordinates(latitude: 45.505914, longitude: -73.566348)
}

public extension Coordinates {
    func toCoordinate2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

public extension CLLocationCoordinate2D {
    func toCoordinates() -> Coordinates {
        .init(latitude: latitude, longitude: longitude)
    }
}
