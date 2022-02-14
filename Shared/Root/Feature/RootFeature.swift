//
//  RootFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import Foundation
import ComposableArchitecture
import CasePaths
import Entities
import Business
import ComposableCoreLocation
import Dashboard
import Common

struct RootState: Equatable {
  var dashboardState = DashboardState()
  var prayerState = PrayerState()
  var azkarState = AzkarState()
  var rewardState = RewardsState()
  var dateState = DateState()
  var settingsState = SettingsState()
}

enum RootAction {
  case dashboardAction(DashboardAction)
  case lifecycleAction(LifecycleAction)
  case locationManager(LocationManager.Action)
  case prayerAction(PrayerAction)
  case azkarAction(AzkarAction)
  case rewardAction(RewardsAction)
  case dateAction(DateAction)
}

struct RootEnvironment { }

let rootReducer = Reducer<
  RootState,
  RootAction,
  CoreEnvironment<RootEnvironment>
>.combine(
  prayerReducer.pullback(
    state: \.prayerState,
    action: /RootAction.prayerAction,
    environment: { _ in .live(PrayerEnvironment()) }
  ),
  azkarReducer.pullback(
    state: \.azkarState,
    action: /RootAction.azkarAction,
    environment: { _ in .live(AzkarEnvironment()) }
  ),
  rewardsReducer.pullback(
    state: \.rewardState,
    action: /RootAction.rewardAction,
    environment: { _ in .live(RewardsEnvironment()) }
  ),
  dateReducer.pullback(
    state: \.dateState,
    action: /RootAction.dateAction,
    environment: { _ in DateEnvironment() }
  ),
  dashboardReducer.pullback(
    state: \.dashboardState,
    action: /RootAction.dashboardAction,
    environment: { _ in .live(DashboardEnvironment()) }
  ),
  syncingReducer
)

fileprivate let syncingReducer: Reducer<RootState, RootAction, CoreEnvironment<RootEnvironment>> = .init { state, action, env in
  switch action {
  case .locationManager(.didChangeAuthorization(.authorizedAlways)),
      .locationManager(.didChangeAuthorization(.authorizedWhenInUse)):
    return env
      .locationManager()
      .requestLocation(id: LocationManagerId())
      .fireAndForget()
    
  case .prayerAction(let prayerAction):
    return syncRewards(with: prayerAction)
  case .azkarAction(let azkarAction):
    return syncRewards(with: azkarAction)
  case .dateAction(let dateAction):
    sync(&state, with: dateAction)
    return .init(value: .prayerAction(.onAppear))
      .append(.azkarAction(.onAppear))
      .append(.rewardAction(.onAppear))
      .append(.dashboardAction(.onAppear))
      .eraseToEffect()
  default:
    break
  }
  
  return .none
}.debug("-Syncing")

fileprivate func sync(_ state: inout RootState, with dateAction: DateAction) {
  switch dateAction {
  case .onAppear:
    state.dateState.currentDay = .now
  case .onChange(let currentDay):
    guard !currentDay.isInFuture else { return }
    state.dateState.currentDay = currentDay
    state.prayerState.activeDate = currentDay
    state.azkarState.activeDate = currentDay
    state.rewardState.activeDate = currentDay
    state.dashboardState.activeDate = currentDay
  }
}

fileprivate func syncRewards(with prayerAction: PrayerAction) -> Effect<RootAction, Never> {
  switch prayerAction {
  case .onDoing(let deed):
    return .init(value: .rewardAction(.onDoingDeed(deed)))
  case .onUndoing(let deed):
    return .init(value: .rewardAction(.onUndoingDeed(deed)))
  default:
    return .none
  }
}

fileprivate func syncRewards(with azkarAction: AzkarAction) -> Effect<RootAction, Never> {
  switch azkarAction {
  case .onDoing(let repeatableDeed):
    return .init(value: .rewardAction(.onDoingRepeatableDeed(repeatableDeed)))
  case .onUndoing(let repeatableDeed):
    return .init(value: .rewardAction(.onUndoingRepeatableDeed(repeatableDeed)))
  case .onQuickFinish(let repeatableDeed):
    return .init(value: .rewardAction(.onUndoingRepeatableDeed(repeatableDeed)))
  default:
    return .none
  }
}

extension Store where State == RootState, Action == RootAction {
  static let mainRoot: Store<State, Action> = .init(
    initialState: .init(),
    reducer: rootReducer,
    environment: .live(RootEnvironment())
  )
}

private struct LocationManagerId: Hashable {}
