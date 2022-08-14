//
//  RootFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import Foundation
import ComposableArchitecture
import CasePaths
import Home
import Common

public struct RootState: Equatable {}

// TODO: - Move to its own Client
public enum LifecycleAction {
  case becameActive
  case becameInActive
  case wentToBackground
}

public enum RootAction {
  case onAppear
  case lifecycleAction(LifecycleAction)
}

public struct RootEnvironment { public init() { } }

public let rootReducer = Reducer<
  RootState,
  RootAction,
  CoreEnvironment<RootEnvironment>
>.combine(
  rootReducerCore
)

fileprivate let rootReducerCore = Reducer<RootState, RootAction, CoreEnvironment<RootEnvironment>> { state, action, env in
  return .none
}

extension Store where State == RootState, Action == RootAction {
  static let mainRoot: Store<State, Action> = .init(
    initialState: .init(),
    reducer: rootReducer,
    environment: CoreEnvironment.live(RootEnvironment())
  )
}
