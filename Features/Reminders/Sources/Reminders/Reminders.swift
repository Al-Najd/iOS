//
//  Reminders.swift
//  Reminders
//
//  Created by Ahmed Ramy on 24/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import ComposableArchitecture
import Foundation
import uCountdown
import uEntities

// MARK: - Reminders

public struct Reminders: ReducerProtocol {
    @Dependency(\.feedback) var feedback

    public struct State: Equatable {
        var countdownTimer: CountdownTimer.State
    }

    struct ViewState: Equatable {
        let progress: Double
        let title: String
        let time: String

        init(state: CountdownTimer.State) { }
    }

    public init() { }

    public enum Action: Equatable {
        case countdown(CountdownTimer.Action)
    }

    public var body: some ReducerProtocol {
        Scope(state: \State.countdownTimer, action: /Action.countdown) {
            CountdownTimer()
        }
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> { }
}
