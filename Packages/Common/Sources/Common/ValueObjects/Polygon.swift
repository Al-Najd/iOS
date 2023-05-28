//
//  Polygon.swift
//  CAFU
//
//  Created by Ahmed Ramy on 14/12/2022.
//

import Configs
import Factory
import Foundation

// MARK: - Polygon

public struct Polygon {
    public let name: String
    public let coordinates: [Coordinates]

    public init(
        name: String,
        coordinates: [Coordinates]) {
        self.name = name
        self.coordinates = coordinates
    }
}

// MARK: Equatable

extension Polygon: Equatable {
    public static func == (lhs: Polygon, rhs: Polygon) -> Bool {
        lhs.coordinates == rhs.coordinates
    }
}

public extension Polygon {
    static let downtonMontreal: Polygon = .init(
        name: "Downtown Montreal",
        coordinates: [
            .init(latitude: 45.513696479916185, longitude: -73.55414914003771),
            .init(latitude: 45.492529, longitude: -73.572276),
            .init(latitude: 45.496524, longitude: -73.581776),
            .init(latitude: 45.518948, longitude: -73.566530)
        ])
}
