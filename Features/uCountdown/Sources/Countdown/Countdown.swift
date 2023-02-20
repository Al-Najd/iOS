//
//  Countdown.swift
//  uEntities
//
//  Created by Ahmed Ramy on 28/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import Dependencies
import Foundation

// MARK: - Countdown

public struct Countdown: Equatable {
    public let startDate: Date
    public let endDate: Date

    public var hasFinished: Bool {
        startDate > endDate
    }

    public init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }

    public func display() -> String {
        CountdownFormatter().format(for: startDate, endDate: endDate)
    }
}

public extension Countdown {
    static let none = Countdown(startDate: .now, endDate: .now)
}
