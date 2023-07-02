//
//  File.swift
//
//
//  Created by Ahmed Ramy on 26/03/2023.
//

import ComposableArchitecture
import Foundation




// MARK: - Azkar

public struct Azkar: ReducerProtocol {
    @Dependency(\.azkarDB)
    var db

    public init() { }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            state.morningAzkar = .init(uniqueElements: db.getMorningAzkar(for: state.date))
            state.nightAzkar = .init(uniqueElements: db.getNightAzkar(for: state.date))
        case .onDoingMorning(let zekr):
            let currentCount = state.morningAzkar[id: zekr.id]?.currentCount ?? 0
            state.morningAzkar[id: zekr.id]?.currentCount = max(0, currentCount - 1)
            db.save(zekr: zekr)
        case .onDoingNight(let zekr):
            let currentCount = state.nightAzkar[id: zekr.id]?.currentCount ?? 0
            state.nightAzkar[id: zekr.id]?.currentCount = max(0, currentCount - 1)
            db.save(zekr: zekr)
        }

        return .none
    }
}

// MARK: Azkar.State

public extension Azkar {
    struct State: Equatable {
        var date = Date().startOfDay
        var morningAzkar: IdentifiedArrayOf<Zekr> = []
        var nightAzkar: IdentifiedArrayOf<Zekr> = []

        public init() { }
    }
}

// MARK: Azkar.Action

public extension Azkar {
    enum Action {
        case onAppear
        case onDoingMorning(Zekr)
        case onDoingNight(Zekr)
    }
}
