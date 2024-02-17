//
//  File.swift
//
//
//  Created by Ahmed Ramy on 11/04/2023.
//


import ComposableArchitecture

import Foundation



// MARK: - NafilaDetails

public struct NafilaDetails: Reducer {
    @Dependency(\.haptic)
    private var haptic

    @Dependency(\.prayersService)
    private var prayersDB

    public init() { }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onDoingNafila:
            state.nafila.isDone = true
            prayersDB.save(nafila: state.nafila)
        case .dismiss:
            break
        }

        haptic.send(.success)
        return .none
    }
}

// MARK: NafilaDetails.State

public extension NafilaDetails {
    struct State: Identifiable, Equatable {
        public var id: Nafila.ID { nafila.id }
        public var nafila: Nafila
        public var date: String

        public init(nafila: Nafila, date: Date) {
            self.nafila = nafila
            self.date = date.format(with: [.dayOfMonth, .monthFull, .yearFull]) ?? ""
        }
    }
}

// MARK: NafilaDetails.Action

public extension NafilaDetails {
    enum Action: Equatable {
        case onDoingNafila
        case dismiss
    }
}
