//
//  File.swift
//
//
//  Created by Ahmed Ramy on 14/08/2022.
//

import Common
import ComposableArchitecture
import Entities
import Foundation
import PrayersClient
import Utils

// MARK: - PrayerDetailsState

public struct PrayerDetailsState: Identifiable, Equatable {
    public var id: ANPrayer.ID { prayer.id }
    public var prayer: ANPrayer
    public var date: String

    public init(
        prayer: ANPrayer,
        date: Date) {
        self.prayer = prayer
        self.date = date.format(with: [.dayOfMonth, .monthFull, .yearFull]) ?? ""
    }
}

// MARK: - PrayerDetailsAction

public enum PrayerDetailsAction: Equatable {
    case onDoingPrayer
    case onDoingSunnah(ANSunnah)
    case onDoingZekr(ANAzkar)
    case onFinishingZekr(ANAzkar)

    case dismiss
}

// MARK: - PrayerDetailsEnvironment

public struct PrayerDetailsEnvironment { public init() { } }

public let prayerDetailsReducer = Reducer<
    PrayerDetailsState,
    PrayerDetailsAction,
    CoreEnvironment<PrayerDetailsEnvironment>
> { state, action, env in
    switch action {
    case .onDoingPrayer:
        state.prayer.isDone = true
        env.prayersClient.save(prayer: state.prayer)
    case .onDoingSunnah(let sunnah):
        state.prayer.sunnah[id: sunnah.id]?.isDone = true
        env.prayersClient.save(sunnah: state.prayer.sunnah[id: sunnah.id])
    case .onDoingZekr(let zekr):
        let currentCount = state.prayer.afterAzkar[id: zekr.id]?.currentCount ?? 0
        state.prayer.afterAzkar[id: zekr.id]?.currentCount = max(0, currentCount - 1)
        env.prayersClient.save(zekr: state.prayer.afterAzkar[id: zekr.id])
    case .onFinishingZekr(let zekr):
        state.prayer.afterAzkar[id: zekr.id]?.currentCount = 0
        env.prayersClient.save(zekr: state.prayer.afterAzkar[id: zekr.id])
    default:
        break
    }
    env.haptic.send(.success)
    return .none
}.debug()
