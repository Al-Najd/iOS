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

// MARK: - Countdown

public struct Countdown: Equatable {
    public let startDate: Date
    public let endDate: Date

    public func display() -> String {
        CountdownFormatter().format(for: startDate, endDate: endDate)
    }
}

// MARK: - CountdownFormatter

public class CountdownFormatter: DateComponentsFormatter {
    override public init() {
        super.init()
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        allowedUnits = [.minute, .second]
        zeroFormattingBehavior = .pad
    }

    public func format(for startDate: Date, endDate: Date) -> String {
        string(from: startDate, to: endDate) ?? "00:00"
    }
}

// MARK: - Reminders

public struct Reminders: ReducerProtocol {
    @Dependency(\.suspendingClock) var clock

    public struct State: Equatable {
        public static let initialTime: TimeInterval = 5 * 60

        public var startDate: Date
        public var timeInterval: TimeInterval
        public var didFinish = false

        public var progress: Percent {
            .init(value: timeInterval / Self.initialTime)
        }

        public var endDate: Date {
            startDate.addingTimeInterval(timeInterval)
        }

        public init(startDate: Date = .now, timeInterval: TimeInterval = Self.initialTime) {
            self.startDate = startDate
            self.timeInterval = timeInterval
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
