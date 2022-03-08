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
import Settings
import Onboarding
import Date
import Prayers
import Azkar
import Rewards
import Location

public struct RootState: Equatable {
  public var locationState: LocationState
  public var dashboardState: DashboardState
  public var prayerState: PrayerState
  public var azkarState: AzkarState
  public var rewardState: RewardsState
  public var dateState: DateState
  public var settingsState: SettingsState
  public var onboardingState: OnboardingState?
  
  public init(
    locationState: LocationState = LocationState(),
    dashboardState: DashboardState = DashboardState(),
    dateState: DateState = .init(),
    settingsState: SettingsState = SettingsState(),
    onboardingState: OnboardingState? = nil
  ) {
    self.locationState = locationState
    self.dashboardState = dashboardState
    self.dateState = dateState
    self.settingsState = settingsState
    self.onboardingState = onboardingState
    self.azkarState = .init(dateState: dateState)
    self.prayerState = .init(dateState: dateState)
    self.rewardState = .init(dateState: dateState)
  }
}

// TODO: - Move to its own Client
public enum LifecycleAction {
  case becameActive
  case becameInActive
  case wentToBackground
}

public enum RootAction {
  case onAppear
  case locationAction(LocationManager.Action)
  case onboardingAction(OnboardingAction)
  case dashboardAction(DashboardAction)
  case lifecycleAction(LifecycleAction)
  case prayerAction(PrayerAction)
  case azkarAction(AzkarAction)
  case rewardAction(RewardsAction)
  case dateAction(DateAction)
  case settingsAction(SettingsAction)
}

public struct RootEnvironment { public init() { } }

public let rootReducer = Reducer<
  RootState,
  RootAction,
  CoreEnvironment<RootEnvironment>
>.combine(
  onboardingReducer
    .optional()
    .pullback(
    state: \.onboardingState,
    action: /RootAction.onboardingAction,
    environment: { _ in .live(OnboardingEnvironment()) }
  ),
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
  settingsReducer.pullback(
    state: \.settingsState,
    action: /RootAction.settingsAction,
    environment: { _ in .live(SettingsEnvironment()) }
  ),
  syncingReducer,
  rootReducerCore
).combined(with: locationManagerReducer.pullback(
  state: \.self,
  action: /RootAction.locationAction,
  environment: { $0 }
))

let rootReducerCore = Reducer<RootState, RootAction, CoreEnvironment<RootEnvironment>> { state, action, env in
  switch action {
    case .onAppear:
      state.onboardingState = env.userDefaults.hasShownFirstLaunchOnboarding ? nil : .init(step: .step0_InMemoryOfOurLovedOnes)
    default:
      break
  }
  return .none
}

fileprivate let syncingReducer: Reducer<RootState, RootAction, CoreEnvironment<RootEnvironment>> = .init { state, action, env in
  switch action {
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
    case .lifecycleAction(.becameActive):
      return .init(value: .settingsAction(.onAppear))
  default:
    break
  }
  
  return .none
}

private let locationManagerReducer: Reducer<
  RootState,
  LocationManager.Action,
  CoreEnvironment<RootEnvironment>
> = .init {
  state, action, env in
  
  switch action {
    case let .didUpdateLocations(locations):
      guard let coordinates = locations.first?.coordinate else { return .none }
      state.locationState.coordinates = coordinates
    default:
      break
  }
  
  return .none
}

fileprivate func sync(_ state: inout RootState, with dateAction: DateAction) {
  switch dateAction {
  case .onAppear:
    state.dateState.currentDay = .now
  case .onChange(let currentDay):
    guard !currentDay.isInFuture else { return }
    state.dateState.currentDay = currentDay
  }
}

fileprivate func syncRewards(with prayerAction: PrayerAction) -> Effect<RootAction, Never> {
  switch prayerAction {
  case .onDoing(let deed):
      return .init(value: .rewardAction(.onDoingDeed(deed.changing { $0.isDone = true })))
  case .onUndoing(let deed):
      return .init(value: .rewardAction(.onUndoingDeed(deed.changing { $0.isDone = false })))
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
    environment: CoreEnvironment.live(RootEnvironment())
  )
}
