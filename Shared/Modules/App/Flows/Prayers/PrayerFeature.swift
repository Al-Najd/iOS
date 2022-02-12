//
//  PrayerFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 21/01/2022.
//

import ComposableArchitecture
import Business
import Entities

struct PrayerState: Equatable {
  var activeDate: Date = .now
  var prayers: [DeedCategory: [Deed]] = [
    .fard: .faraaid,
    .sunnah: .sunnah,
    .nafila: .nafila
  ]
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
  SystemEnvironment<PrayerEnvironment>
> { state, action, env in
  switch action {
  case .onAppear:
    state.prayers = getPrayersCategorized(env.cache(), state.activeDate)
  case let .onDoing(deed):
    var mutation = deed
    mutation.isDone = true
    state.prayers[deed.category]?.findAndReplaceElseAppend(with: mutation)
    updateCache(state, env)
  case var .onUndoing(deed):
    var mutation = deed
    mutation.isDone = false
    state.prayers[deed.category]?.findAndReplaceElseAppend(with: mutation)
    updateCache(state, env)
  }
  
  return .none
}.debug()

fileprivate func updateCache(_ state: PrayerState, _ env: SystemEnvironment<PrayerEnvironment>) {
  state.prayers.forEach {
    env.cache().save($0.value, for: .prayers(state.activeDate, $0.key))
  }
}
