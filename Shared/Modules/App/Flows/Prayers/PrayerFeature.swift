//
//  PrayerFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 21/01/2022.
//

import ComposableArchitecture
import Business
import Entities
import Common

struct PrayerState: Equatable {
  var activeDate: Date = .now
  var prayers: [Deed.Categorized] = [
    .faraaid,
    .sunnah,
    .nafila
  ]
  
  public static func == (lhs: PrayerState, rhs: PrayerState) -> Bool {
    lhs.activeDate == rhs.activeDate &&
    lhs.prayers[0] == rhs.prayers[0] &&
    lhs.prayers[1] == rhs.prayers[1] &&
    lhs.prayers[2] == rhs.prayers[2]
  }
}

enum PrayerAction: Equatable {
  case onAppear
  case onDoing(Deed)
  case onUndoing(Deed)
}

struct PrayerEnvironment {}

let prayerReducer = Reducer<
  PrayerState,
  PrayerAction,
  CoreEnvironment<PrayerEnvironment>
> { state, action, env in
  switch action {
  case .onAppear:
    state.prayers = env.getPrayersCategorized(state.activeDate)
  case let .onDoing(deed):
    guard let index = state.prayers.firstIndex(where: { $0.category == deed.category }) else { return .none }
    guard let deedIndex = state.prayers[index].deeds.firstIndex(of: deed) else { return .none }
    state.prayers[index].deeds[deedIndex].isDone = true
    updateCache(state, env)
  case var .onUndoing(deed):
    guard let index = state.prayers.firstIndex(where: { $0.category == deed.category }) else { return .none }
    guard let prayerIndex = state.prayers[index].deeds.firstIndex(of: deed) else { return .none }
    state.prayers[index].deeds[prayerIndex].isDone = true
    updateCache(state, env)
  }
  
  return .none
}


fileprivate func updateCache(_ state: PrayerState, _ env: CoreEnvironment<PrayerEnvironment>) {
  state.prayers.forEach {
    env.cache().save($0.deeds, for: .prayers(state.activeDate, $0.category))
  }
}
