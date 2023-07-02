//
//  File.swift
//
//
//  Created by Ahmed Ramy on 11/04/2023.
//


import ComposableArchitecture

import Foundation



// MARK: - NafilaDetails

public struct NafilaDetails: ReducerProtocol {
    @Dependency(\.haptic)
    private var haptic

    @Dependency(\.prayersDB)
    private var prayersDB

    public init() { }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
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
        public var id: ANNafila.ID { nafila.id }
        public var nafila: ANNafila
        public var date: String

        public init(nafila: ANNafila, date: Date) {
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
