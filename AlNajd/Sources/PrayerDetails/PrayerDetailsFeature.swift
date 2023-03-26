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

public struct PrayerDetails: ReducerProtocol {
    @Dependency(\.haptic)
    private var haptic

    @Dependency(\.prayersDB)
    private var prayersDB

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onDoingPrayer:
                state.prayer.isDone = true
                prayersDB.save(prayer: state.prayer)
            case .onDoingSunnah(let sunnah):
                state.prayer.sunnah[id: sunnah.id]?.isDone = true
                prayersDB.save(sunnah: state.prayer.sunnah[id: sunnah.id])
            case .onDoingZekr(let zekr):
                let currentCount = state.prayer.afterAzkar[id: zekr.id]?.currentCount ?? 0
                state.prayer.afterAzkar[id: zekr.id]?.currentCount = max(0, currentCount - 1)
                prayersDB.save(zekr: state.prayer.afterAzkar[id: zekr.id])
            case .onFinishingZekr(let zekr):
                state.prayer.afterAzkar[id: zekr.id]?.currentCount = 0
                prayersDB.save(zekr: state.prayer.afterAzkar[id: zekr.id])
            default:
                break
            }
            haptic.send(.success)

            return .none
        }
    }
}

extension PrayerDetails {
    public struct State: Identifiable, Equatable {
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
}

// MARK: - PrayerDetailsAction

extension PrayerDetails {
    public enum Action: Equatable {
        case onDoingPrayer
        case onDoingSunnah(ANSunnah)
        case onDoingZekr(ANAzkar)
        case onFinishingZekr(ANAzkar)

        case dismiss
    }
}
