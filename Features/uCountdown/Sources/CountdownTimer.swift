//
//  CountdownTimer.swift
//  uTasksService
//
//  Created by Ahmed Ramy on 02/02/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import ComposableArchitecture
import Foundation

public struct CountdownTimer: ReducerProtocol {
    @Dependency(\.suspendingClock) var clock

    public init() { }

    public struct State: Equatable {
        public var startDate: Date
        public var timeInterval: TimeInterval
        var initialTimeInterval: TimeInterval

        public var countdown: Countdown {
            Countdown(startDate: startDate, endDate: startDate.addingTimeInterval(timeInterval))
        }

        public init(startDate: Date = .now, timeInterval: TimeInterval) {
            self.startDate = startDate
            self.timeInterval = timeInterval
            initialTimeInterval = timeInterval
        }
    }

    public enum Action: Equatable {
        case start
        case stop
        case update
        case finish
        case delegate(DelegateAction)
    }

    struct CancelationId: Hashable { }

    public enum DelegateAction: Equatable {
        case timerUpdated(State)
        case didFinish(State)
    }

    public struct Failed: Equatable, Error { }


    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .start:
            let startDate = Date()
            let initialTimeInterval = state.initialTimeInterval
            state.startDate = startDate
            return .run { promise in
                for await _ in clock.timer(interval: .seconds(1))
                    where !checkIfTimerShouldStop(startDate: startDate, initialTimeInterval: initialTimeInterval) {
                    await promise.send(.update)
                }
            }.cancellable(id: CancelationId(), cancelInFlight: true)
        case .stop:
            return .cancel(id: CancelationId())
        case .update:
            state.timeInterval -= 1
            return checkIfFinished(startDate: state.startDate, initialTimeInterval: state.initialTimeInterval)
                ? .run { await $0.send(.finish) }
                : .run { [state] in await $0.send(.delegate(.timerUpdated(state))) }
        case .finish:
            return .run { [state] in await $0.send(.delegate(.didFinish(state))) }
        case .delegate:
            return .none
        }
    }

    private func checkIfTimerShouldStop(startDate: Date, initialTimeInterval: TimeInterval) -> Bool {
        Date() > startDate.addingTimeInterval(initialTimeInterval + 1)
    }

    private func checkIfFinished(startDate: Date, initialTimeInterval: TimeInterval) -> Bool {
        Date() > startDate.addingTimeInterval(initialTimeInterval)
    }
}
