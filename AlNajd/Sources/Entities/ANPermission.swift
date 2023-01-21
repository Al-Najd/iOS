//
//  ANPermission.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 15/02/2022.
//

import CoreLocation
import Foundation

public struct ANPermission: Identifiable, Equatable {
    public let id: String = UUID().uuidString
    public let title: String
    public let icon: String
    public let subtitles: String

    /// Description of what this permission is used for
    public let usages: [String]
    public var status: Status
    public let isInternal: Bool

    public init(
        title: String,
        icon: String,
        subtitles: String,
        needs: [String],
        status: Status = .notDetermined,
        isInternal: Bool
    ) {
        self.title = title
        self.icon = icon
        self.subtitles = subtitles
        usages = needs
        self.status = status
        self.isInternal = isInternal
    }
}

public extension ANPermission {
    enum Status: Equatable, Codable {
        case notDetermined
        case given
        case denied
        case insufficient(reason: String)

        public init(_ authorization: CLAuthorizationStatus) {
            switch authorization {
            case .notDetermined:
                self = .notDetermined
            case .denied,
                 .restricted:
                self = .denied
            case .authorizedAlways,
                 .authorizedWhenInUse,
                 .authorized:
                self = .given
            @unknown default:
                self = .notDetermined
            }
        }
    }

    enum `Type`: Equatable {
        case `internal`
        case iOS
    }
}
