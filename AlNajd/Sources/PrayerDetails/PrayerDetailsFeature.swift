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

public struct PrayerDetailsState: Equatable {
    public var prayer: ANPrayer
    
    public init(prayer: ANPrayer = .fajr) {
        self.prayer = prayer
    }
}

public enum PrayerDetailsAction: Equatable {
    case dismiss
}

public struct PrayerDetailsEnvironment { public init() { } }

public let prayerDetailsReducer = Reducer<
    PrayerDetailsState,
    PrayerDetailsAction,
    CoreEnvironment<PrayerDetailsEnvironment>
> { state, action, env in
    return .none
}
