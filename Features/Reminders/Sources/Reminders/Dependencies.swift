//
//  Dependencies.swift
//  Reminders
//
//  Created by Ahmed Ramy on 28/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - CountdownClockClient

struct CountdownClockClient {
    var clock: () -> ContinuousClock
}

// MARK: DependencyKey

extension CountdownClockClient: DependencyKey {
    static let liveValue = Self {
        ContinuousClock()
    }
}

extension DependencyValues {
    var countDownClock: CountdownClockClient {
        get { self[CountdownClockClient.self] }
        set { self[CountdownClockClient.self] = newValue }
    }
}
