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

// MARK: - RootState

public struct Root: ReducerProtocol {
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.home, action: /Action.home) {
      Home()
    }
  }
}

public extension Root {
  struct State: Equatable {
    var home: Home.State = .init()
//    var dashboard: Dashboard.State = .init()
  }
}

public extension Root {
  enum Action {
    case onAppear
    case home(Home.Action)
  }
}
