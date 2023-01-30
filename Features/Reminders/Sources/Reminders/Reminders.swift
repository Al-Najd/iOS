//
//  Reminders.swift
//  Reminders
//
//  Created by Ahmed Ramy on 24/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import ComposableArchitecture
import Foundation
import uEntities

// MARK: - Reminders

public struct Reminders: ReducerProtocol {
    @Dependency(\.suspendingClock) var clock
    @Dependency(\.feedback) var feedback
    @Dependency(\.countDownFormatter) var formatter

    public struct State: Equatable {
        public static let initialTime: TimeInterval = 60 * 5

        public var startDate: Date
        public var timeInterval: TimeInterval
        public var didFinish = false

        public var progress: Percent {
            .init(value: timeInterval / Self.initialTime)
        }

        public var endDate: Date {
            startDate.addingTimeInterval(timeInterval)
        }

        var displayTime: String?

        public init(startDate: Date = .now, timeInterval: TimeInterval = Self.initialTime) {
            self.startDate = startDate
            self.timeInterval = timeInterval
        }
    }

    struct ViewState: Equatable {
        let progress: Double
        let title: String
        let time: String

        init(state: State) {
            progress = state.progress.value
            title = state.didFinish ? "Well Done!" : "5 Mins of Azkar"
            time = state.displayTime ?? ""
        }
    }

    public init() { }

    public enum Action: Equatable {
        case start
        case decrementTimeInterval
        case finish
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .start:
            let startDate = Date()
            state.startDate = startDate
            state.displayTime = formatter.formate(startDate, state.endDate)
            return .run { promise in
                for await _ in clock.timer(interval: .seconds(1)) where !checkIfTimerShouldStop(startDate: startDate) {
                    await promise.send(.decrementTimeInterval)
                }
            }
        case .decrementTimeInterval:
            state.timeInterval -= 1
            return checkIfFinished(startDate: state.startDate)
                ? .run { promise in await promise.send(.finish) }
                : .none

        case .finish:
            state.didFinish = true
            Vibration.oldSchool.vibrate()
            feedback.audio.play(sound: .countdownFinish)
            return .none
        }
    }

    private func checkIfTimerShouldStop(startDate: Date) -> Bool {
        Date() > startDate.addingTimeInterval(State.initialTime + 1)
    }

    private func checkIfFinished(startDate: Date) -> Bool {
        Date() > startDate.addingTimeInterval(State.initialTime)
    }
}
