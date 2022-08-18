//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 14/08/2022.
//

import ComposableArchitecture
import Entities
import PrayersClient
import Common
import TCACoordinators
import Utils

public struct PrayerDetailsState: Equatable {
    public var prayer: ANPrayer
    
    public init(prayer: ANPrayer) {
        self.prayer = prayer
    }
}

public enum PrayerDetailsAction: Equatable {
    case onDoingPrayer
    case onDoingSunnah(ANSunnah)
    case onDoingZekr(ANAzkar)
    case onFinishingZekr(ANAzkar)
    
    case dismiss
}

public struct PrayerDetailsEnvironment { public init() { } }

public let prayerDetailsReducer = Reducer<
    PrayerDetailsState,
    PrayerDetailsAction,
    CoreEnvironment<PrayerDetailsEnvironment>
> { state, action, env in
    switch action {
    case .onDoingPrayer:
        state.prayer.isDone = true
    case let .onDoingSunnah(sunnah):
        state.prayer.sunnah.replace(sunnah, with: sunnah.changing { $0.isDone = true })
    case let .onDoingZekr(zekr):
        state.prayer.afterAzkar.replace(zekr, with: zekr.changing { $0.currentCount = max(0, $0.currentCount - 1) })
    case let .onFinishingZekr(zekr):
        state.prayer.afterAzkar.replace(zekr, with: zekr.changing { $0.currentCount = 0 })
    default:
        break
    }
    return .none
}.debug()
