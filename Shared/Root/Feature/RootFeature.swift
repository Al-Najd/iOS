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
  SystemEnvironment<RootEnvironment>
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
    environment: { _ in DashboardEnvironment() }
  ),
  syncingReducer
)

fileprivate let syncingReducer: Reducer<RootState, RootAction, SystemEnvironment<RootEnvironment>> = .init { state, action, env in
  switch action {
  case .lifecycleAction(.becameActive):
    return .init(
      value: .dashboardAction(
        .seed(
          current: getLastWeekReport(env,state.dateState.currentDay),
          previous: getLastWeekReport(env,state.dateState.currentDay.adding(.day, value: -7))
        )
      )
    )
  case .lifecycleAction(.becameInActive),
      .lifecycleAction(.wentToBackground):
    break
  case .locationManager(.didChangeAuthorization(.authorizedAlways)),
      .locationManager(.didChangeAuthorization(.authorizedWhenInUse)):
    
    return env
      .locationManager()
      .requestLocation(id: LocationManagerId())
      .fireAndForget()
    
  case .locationManager(.didChangeAuthorization(.denied)),
       .locationManager(.didChangeAuthorization(.restricted)):
    return .none
  case .prayerAction(let prayerAction):
    sync(&state, with: prayerAction)
    updateCache(state, env)
    
    return .init(
      value: .dashboardAction(
        .seed(
          current: getLastWeekReport(env,state.dateState.currentDay),
          previous: getLastWeekReport(env,state.dateState.currentDay.adding(.day, value: -7))
        )
      )
    )
  case .azkarAction(let azkarAction):
    sync(&state, with: azkarAction)
    updateCache(state, env)
    
    return .init(
      value: .dashboardAction(
        .seed(
          current: getLastWeekReport(env,state.dateState.currentDay),
          previous: getLastWeekReport(env,state.dateState.currentDay.adding(.day, value: -7))
        )
      )
    )
  case .dateAction(let dateAction):
    sync(&state, with: dateAction)
    return .init(value: .prayerAction(.onAppear))
      .append(.azkarAction(.onAppear))
      .append(.rewardAction(.onAppear))
      .append(
        .dashboardAction(
          .seed(
            current: getLastWeekReport(env,state.dateState.currentDay),
            previous: getLastWeekReport(env,state.dateState.currentDay.adding(.day, value: -7))
          )
        )
      )
      .eraseToEffect()
  default:
    break
  }
  
  return .none
}

fileprivate func updateCache(_ state: RootState, _ env: SystemEnvironment<RootEnvironment>) {
  state.prayerState.prayers.forEach {
    env.cache().save($0.value.filter { $0.isDone }, for: .prayersRewards(state.dateState.currentDay, $0.key))
  }
  
  state.azkarState.azkar.forEach {
    env.cache().save($0.value.filter { $0.isDone }, for: .azkarRewards(state.dateState.currentDay, $0.key))
  }
}

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
  }
}

fileprivate func sync(_ state: inout RootState, with prayerAction: PrayerAction) {
  switch prayerAction {
  case .onDoing(let deed):
    state.rewardState.prayers[deed.category]?.append(deed)
  case .onUndoing(let deed):
    state.rewardState.prayers[deed.category]?.findAndRemove(deed)
  default:
    break
  }
}

fileprivate func sync(_ state: inout RootState, with azkarAction: AzkarAction) {
  switch azkarAction {
  case .onDoing(let repeatableDeed):
    decrement(deed: repeatableDeed, in: &state)
  case .onUndoing(let repeatableDeed):
    undo(deed: repeatableDeed, in: &state)
  case .onQuickFinish(let repeatableDeed):
    did(deed: repeatableDeed, in: &state)
  default:
    break
  }
}

fileprivate func decrement(
  deed: RepeatableDeed,
  in state: inout RootState
) {
  guard deed.currentNumberOfRepeats > 0 else { return }
  var deed = deed
  deed.currentNumberOfRepeats -= 1
  guard deed.currentNumberOfRepeats == 0 else { return }
  switch deed.category {
  case .masaa:
    state.azkarState.azkar[.masaa]?.findAndReplaceElseAppend(with: deed)
  case .sabah:
    state.azkarState.azkar[.sabah]?.findAndReplaceElseAppend(with: deed)
  }
  
  HapticService.main.generate(feedback: .success)
}

fileprivate func did(deed: RepeatableDeed, in state: inout RootState) {
  var deed = deed
  deed.currentNumberOfRepeats = 0
  switch deed.category {
  case .masaa:
    state.azkarState.azkar[.masaa]?.findAndReplaceElseAppend(with: deed)
  case .sabah:
    state.azkarState.azkar[.sabah]?.findAndReplaceElseAppend(with: deed)
  }
  HapticService.main.generate(feedback: .success)
}

fileprivate func undo(deed: RepeatableDeed, in state: inout RootState) {
  var deed = deed
  deed.currentNumberOfRepeats = deed.numberOfRepeats
  switch deed.category {
  case .masaa:
    state.azkarState.azkar[.masaa]?.findAndReplaceElseAppend(with: deed)
  case .sabah:
    state.azkarState.azkar[.sabah]?.findAndReplaceElseAppend(with: deed)
  }
  HapticService.main.generate(feedback: .warning)
}

fileprivate func getLastWeekReport(
  _ env: SystemEnvironment<RootEnvironment>,
  _ activeDay: Date
) -> Report.Range {
  .init(
    ranges: DeedCategory
      .allCases
      .reduce(
        into: [DeedCategory: [Date: [Deed]]]()
      ) { dictionary, category in
        dictionary[category] = activeDay.previousWeek.reduce(into: [Date: [Deed]]()) { dictionary, date in
          dictionary[date] = getPrayersFromCache(env.cache(), date, category) ?? category.defaultDeeds
        }
      }
  )
}

extension Store where State == RootState, Action == RootAction {
  static let mainRoot: Store<State, Action> = .init(
    initialState: .init(),
    reducer: rootReducer,
    environment: .live(RootEnvironment())
  )
}

private struct LocationManagerId: Hashable {}
