//
//  RootFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import CasePaths
import ComposableArchitecture
import Foundation



// MARK: - Root

public struct Root: ReducerProtocol {
    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.home, action: /Action.home) {
            Home()
        }

        Scope(state: \.dashboard, action: /Action.dashboard) {
            Dashboard()
        }

        Scope(state: \.azkar, action: /Action.azkar) {
            Azkar()
        }
    }
}

public extension StoreOf {
    static var mainRoot: StoreOf<Root> { .init(initialState: .init(), reducer: Root()) }
}

// MARK: - Root.State

public extension Root {
    struct State: Equatable {
        var home: Home.State = .init()
        var dashboard: Dashboard.State = .init()
        var azkar: Azkar.State = .init()
    }
}

// MARK: - Root.Action

public extension Root {
    enum Action {
        case onAppear
        case home(Home.Action)
        case dashboard(Dashboard.Action)
        case azkar(Azkar.Action)
    }
}
