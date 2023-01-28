//
//  Countdown.swift
//  uEntities
//
//  Created by Ahmed Ramy on 28/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import Foundation

public struct Countdown: Equatable {
    public let startDate: Date
    public let endDate: Date

    public init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }

    public func display() -> String {
        CountdownFormatter().format(for: startDate, endDate: endDate)
    }
}
