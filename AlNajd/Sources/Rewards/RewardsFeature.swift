//
//  RewardsFeature.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import Foundation
import ComposableArchitecture
import Business
import Entities
import Common
import Date

public struct RewardsState: Equatable {
    public var activeDate: Date = .init()
    public var prayers: [DeedCategory: [Deed]] = [
        .fard: [],
        .sunnah: [],
        .nafila: []
    ]
    
    public var azkar: [AzkarCategory: [RepeatableDeed]] = [
        .sabah: [],
        .masaa: []
    ]
    
    public init(activeDate: Date = .init()) {
        self.activeDate = activeDate
    }
}

public enum RewardsAction: Equatable {
    case onAppear
    case onChange(Date)
    case onDoingDeed(Deed)
    case onUndoingDeed(Deed)
    case onDoingRepeatableDeed(RepeatableDeed)
    case onUndoingRepeatableDeed(RepeatableDeed)
    case onQuickFinishRepeatableDeed(RepeatableDeed)
}

public struct RewardsEnvironment { public init() { } }

public let rewardsReducer = Reducer<
    RewardsState,
    RewardsAction,
    CoreEnvironment<RewardsEnvironment>
> { state, action, env in
    switch action {
        case .onAppear:
            DeedCategory.allCases.forEach {
                state.prayers[$0] = env.getPrayersRewardsFromCache(state.activeDate, $0)
            }
            
            AzkarCategory.allCases.forEach {
                state.azkar[$0] = env.getAzkarRewardsFromCache(state.activeDate, $0)
            }
        case let .onDoingDeed(deed):
            if state.prayers[deed.category] != nil {
                state.prayers[deed.category]?.findAndReplaceElseAppend(with: deed)
            } else {
                state.prayers[deed.category] = [deed]
            }
            cachePrayerRewards(state, env)
        case let .onUndoingDeed(deed):
            state.prayers[deed.category]?.findAndRemove(deed)
            cachePrayerRewards(state, env)
        case let .onDoingRepeatableDeed(repeatableDeed: deed):
            if state.azkar[deed.category] != nil {
                state.azkar[deed.category]?.findAndReplaceElseAppend(with: deed)
            } else {
                state.azkar[deed.category] = [deed]
            }
            cacheAzkarRewards(state, env)
        case let .onUndoingRepeatableDeed(repeatableDeed: deed):
            state.azkar[deed.category]?.findAndRemove(deed)
            cacheAzkarRewards(state, env)
        case let .onQuickFinishRepeatableDeed(repeatableDeed: deed):
            if state.azkar[deed.category] != nil {
                state.azkar[deed.category]?.findAndReplaceElseAppend(with: deed)
            } else {
                state.azkar[deed.category] = [deed]
            }
            cacheAzkarRewards(state, env)
        case let .onChange(date):
            state.activeDate = date
            return .init(value: .onAppear)
    }
    
    return .none
}

fileprivate func cachePrayerRewards(_ state: RewardsState, _ env: CoreEnvironment<RewardsEnvironment>) {
    state.prayers.forEach {
        env.cache().save($0.value.filter { $0.isDone }, for: .prayersRewards(state.activeDate, $0.key))
    }
}

fileprivate func cacheAzkarRewards(_ state: RewardsState, _ env: CoreEnvironment<RewardsEnvironment>) {
    state.azkar.forEach {
        env.cache().save($0.value.filter { $0.isDone }, for: .azkarRewards(state.activeDate, $0.key))
    }
}

public extension Store where State == RewardsState, Action == RewardsAction {
    static let dev: (
        _ prayers: [Deed],
        _ azkar: [RepeatableDeed]
    ) -> (Store<RewardsState, RewardsAction>) = { prayers, azkar in
        let env = CoreEnvironment.live(RewardsEnvironment())
        env.cache().save(
            prayers,
            for: .prayers(
                .now,
                .fard
            )
        )
        
        env.cache().save(
            azkar,
            for: .azkar(
                .now,
                .sabah
            )
        )
        
        return .init(
            initialState: .init(),
            reducer: rewardsReducer,
            environment: env
        )
    }
}
