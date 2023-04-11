//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 11/04/2023.
//

import Common
import ComposableArchitecture
import Entities
import Foundation
import Localization
import PrayersClient

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

extension NafilaDetails {
    public struct State: Identifiable, Equatable {
        public var id: ANNafila.ID { nafila.id }
        public var nafila: ANNafila
        public var date: String

        public init(nafila: ANNafila, date: Date) {
                self.nafila = nafila
                self.date = date.format(with: [.dayOfMonth, .monthFull, .yearFull]) ?? ""
            }
    }
}

extension NafilaDetails {
    public enum Action: Equatable {
        case onDoingNafila
        case dismiss
    }
}
