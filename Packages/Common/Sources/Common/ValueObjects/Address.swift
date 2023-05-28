//
//  Address.swift
//  CAFU
//
//  Created by Ahmed Allam on 18/11/2022.
//

import ContentEV
import Foundation

// MARK: - Address

public struct Address: Equatable {
    public var title: String
    public let subtitle: String
    public let coordinates: Coordinates

    public init(
        title: String,
        subtitle: String,
        coordinates: Coordinates) {
        self.title = title
        self.subtitle = subtitle
        self.coordinates = coordinates
    }
}

public extension Address {
    static let emptyAddress = Address(title: "", subtitle: "", coordinates: .default)
    static let unknownAddress = Address(title: EVStrings.homeLocationTitleUnknownCase, subtitle: "", coordinates: .default)
}
