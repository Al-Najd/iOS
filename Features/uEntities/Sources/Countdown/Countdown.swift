//
//  Countdown.swift
//  uEntities
//
//  Created by Ahmed Ramy on 28/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import Dependencies
import Foundation

// MARK: - CounterDepend

public struct CounterDepend {
    public var formate: (_ startDate: Date, _ endDate: Date) -> String
    private static var formatter: CountdownFormatter = .init()
}

public extension DependencyValues {
    var countDownFormatter: CounterDepend {
        get { self[CounterDepend.self] }
        set { self[CounterDepend.self] = newValue }
    }
}

// MARK: - CounterDepend + DependencyKey

extension CounterDepend: DependencyKey {
    public static var liveValue: CounterDepend {
        CounterDepend { startDate, endDate in
            formatter.format(for: startDate, endDate: endDate)
        }
    }
}

// extension AudioFeedbackClient: DependencyKey {
//    static let liveValue = Self(audio: .shared)
// }
//
// extension DependencyValues {
//    var feedback: AudioFeedbackClient {
//        get { self[AudioFeedbackClient.self] }
//        set { self[AudioFeedbackClient.self] = newValue }
//    }
// }
