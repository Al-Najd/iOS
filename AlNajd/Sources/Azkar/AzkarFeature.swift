//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 26/03/2023.
//

import Foundation
import ComposableArchitecture
import Entities
import Common
import PrayersClient

public struct Azkar: ReducerProtocol {
    @Dependency(\.azkarDB)
    var db

    public init() { }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            state.morningAzkar = .init(uniqueElements: db.getMorningAzkar(for: state.date))
            state.nightAzkar = .init(uniqueElements: db.getNightAzkar(for: state.date))
        case let .onDoingMorning(zekr):
            let currentCount = state.morningAzkar[id: zekr.id]?.currentCount ?? 0
            state.morningAzkar[id: zekr.id]?.currentCount = max(0, currentCount - 1)
            db.save(zekr: zekr)
        case let .onDoingNight(zekr):
            let currentCount = state.nightAzkar[id: zekr.id]?.currentCount ?? 0
            state.nightAzkar[id: zekr.id]?.currentCount = max(0, currentCount - 1)
            db.save(zekr: zekr)
        }

        return .none
    }
}

extension Azkar {
    public struct State: Equatable {
        var date: Date = Date().startOfDay
        var morningAzkar: IdentifiedArrayOf<ANAzkar> = []
        var nightAzkar: IdentifiedArrayOf<ANAzkar> = []

        public init() { }
    }
}

extension Azkar {
    public enum Action {
        case onAppear
        case onDoingMorning(ANAzkar)
        case onDoingNight(ANAzkar)
    }
}
