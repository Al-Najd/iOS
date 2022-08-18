//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import ComposableArchitecture
import Entities
import PrayersClient
import Common
import TCACoordinators

public struct HomeState: Equatable {
    public var prayers: [ANPrayer]
    
    public init(prayers: [ANPrayer] = .faraaid) {
        self.prayers = prayers
    }
}

public enum HomeAction: Equatable {
    case onSelecting(ANPrayer)
}

public struct HomeEnvironment { public init() { } }

public let homeReducer = Reducer<
    HomeState,
    HomeAction,
    CoreEnvironment<HomeEnvironment>
> { state, action, env in
    state.prayers = env.prayersClient.prayers
    return .none
}
