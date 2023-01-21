//
//  RootFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import CasePaths
import Common
import ComposableArchitecture
import Dashboard
import Foundation
import Home
import PrayerDetails

public struct RootState: Equatable {
    var home: HomeState = .init()
    var dashboard: DashboardState = .init()
}

public enum RootAction: Equatable {
    case onAppear
    case home(HomeAction)
    case dashboard(DashboardAction)
}

public struct RootEnvironment { public init() {} }

public let rootReducer = Reducer<
    RootState,
    RootAction,
    CoreEnvironment<RootEnvironment>
>.combine(
    homeReducer
        .pullback(
            state: \RootState.home,
            action: /RootAction.home,
            environment: { _ in CoreEnvironment.live(HomeEnvironment()) }
        ),
    dashboardReducer
        .pullback(
            state: \RootState.dashboard,
            action: /RootAction.dashboard,
            environment: { _ in .live(.init()) }
        ),
    rootReducerCore
)

private let rootReducerCore = Reducer<RootState, RootAction, CoreEnvironment<RootEnvironment>> { _, _, _ in
    .none
}

extension Store where State == RootState, Action == RootAction {
    static let mainRoot: Store<State, Action> = .init(
        initialState: .init(),
        reducer: rootReducer,
        environment: CoreEnvironment.live(RootEnvironment())
    )
}
