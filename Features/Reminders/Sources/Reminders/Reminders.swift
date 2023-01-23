//
//  Reminders.swift
//  Reminders
//
//  Created by Ahmed Ramy on 24/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import ComposableArchitecture
import Foundation

struct Reminders: ReducerProtocol {
    struct State: Equatable {
        var startDate: Date = .init()
        var endDate: Date = .init()
    }

    enum Action: Equatable {
        case start
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .start:
            state.startDate = Date()
            state.endDate = Date().addingTimeInterval(60 * 5)

            return .none
        }
    }
}
