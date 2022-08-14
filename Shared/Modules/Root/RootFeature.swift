//
//  RootFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import Foundation
import ComposableArchitecture
import TCACoordinators
import CasePaths
import Home
import Common
import PrayerDetails

public enum RootState: Equatable {
  case home(HomeState)
  case prayerDetails(PrayerDetailsState)
  
  static let initial: RootState = .home(.init())
}

public enum RootAction: Equatable {
  case onAppear
  case home(HomeAction)
  case prayerDetails(PrayerDetailsAction)
}

public struct RootEnvironment { public init() { } }

public let rootReducer = Reducer<
  RootState,
  RootAction,
  CoreEnvironment<RootEnvironment>
>.combine(
  homeReducer
    .pullback(
      state: /RootState.home,
      action: /RootAction.home,
      environment: { _ in .live(.init()) }
    ),
  prayerDetailsReducer
    .pullback(
      state: /RootState.prayerDetails,
      action: /RootAction.prayerDetails,
      environment: { _ in .live(.init()) }
    ),
  rootReducerCore
)

fileprivate let rootReducerCore = Reducer<RootState, RootAction, CoreEnvironment<RootEnvironment>> { state, action, env in
  return .none
}

extension Store where State == RootState, Action == RootAction {
  static let mainRoot: Store<State, Action> = .init(
    initialState: .home(HomeState()),
    reducer: rootReducer,
    environment: CoreEnvironment.live(RootEnvironment())
  )
}

public struct CoordinatorState: Equatable, IndexedRouterState {
  public var routes: [Route<RootState>]
  
  init(routes: [Route<RootState>] = [
    .root(.initial)
  ]) {
    self.routes = routes
  }
}

public enum CoordinatorAction: IndexedRouterAction {
  case routeAction(Int, action: RootAction)
  case updateRoutes([Route<RootState>])
}

public let coordinatorReducer: Reducer<CoordinatorState, CoordinatorAction, Void> = rootReducer
  .forEachIndexedRoute(environment: { _ in .live(.init()) })
  .withRouteReducer(
    Reducer<CoordinatorState, CoordinatorAction, Void> { state, action, environment in
      switch action {
      case let .routeAction(_, action: .home(.onSelecting(prayer))):
        state.routes.presentCover(RootState.prayerDetails(.init(prayer: prayer)))
      case .routeAction(_, action: .prayerDetails(.dismiss)):
        state.routes.dismiss()
      default:
        break
      }
      
      return .none
    }
  )

