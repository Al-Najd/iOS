//
//  AzkarFeature.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 21/01/2022.
//

import Foundation
import ComposableArchitecture
import Entities
import Common
import Date
import Date

struct AzkarState: Equatable {
  var activeDate: Date { dateState.currentDay }
  var dateState: DateState
  var azkar: [AzkarCategory: [RepeatableDeed]] = [
    .sabah: .sabah,
    .masaa: .masaa
  ]
}

enum AzkarAction: Equatable {
  case onAppear
  case onDoing(RepeatableDeed)
  case onUndoing(RepeatableDeed)
  case onQuickFinish(RepeatableDeed)
}

struct AzkarEnvironment {}

let azkarReducer = Reducer<
  AzkarState,
  AzkarAction,
  CoreEnvironment<AzkarEnvironment>
> { state, action, env in
  switch action {
  case .onAppear:
    state.azkar = env.getAzkarCategorized(state.activeDate)
  case let .onDoing(deed):
    update(&state, using: deed, with: true)
    updateCache(state, env)
  case let .onUndoing(deed):
    update(&state, using: deed, with: false)
    updateCache(state, env)
  case let .onQuickFinish(deed):
    finish(deed, in: &state)
    updateCache(state, env)
  }
  
  return .none
}

fileprivate func updateRepeatableDeeds(_ updatedRepeatableDeed: RepeatableDeed, _ isDone: Bool) -> ((RepeatableDeed) -> RepeatableDeed) {
  return {
    guard $0 == updatedRepeatableDeed else { return $0 }
    var mutatedDeed = $0
    mutatedDeed.currentNumberOfRepeats += (isDone ? -1 : +1)
    mutatedDeed.currentNumberOfRepeats = mutatedDeed.currentNumberOfRepeats.clamped(to: (0...1000))
    return mutatedDeed
  }
}

fileprivate func update(_ state: inout AzkarState, using deed: RepeatableDeed, with isDone: Bool) {
  state.azkar[deed.category] = state.azkar[deed.category]!.map(updateRepeatableDeeds(deed, isDone))
}

fileprivate func finishRepeatableDeedsQuickly(_ deed: RepeatableDeed) -> ((RepeatableDeed) -> RepeatableDeed) {
  return {
    guard $0 == deed else { return $0 }
    var mutatedDeed = $0
    mutatedDeed.currentNumberOfRepeats = 0
    return mutatedDeed
  }
}

fileprivate func finish(_ deed: RepeatableDeed, in state: inout AzkarState) {
  state.azkar[deed.category] = state.azkar[deed.category]!.map(finishRepeatableDeedsQuickly(deed))
}

fileprivate func updateCache(_ state: AzkarState, _ env: CoreEnvironment<AzkarEnvironment>) {
  state.azkar.forEach {
    env.cache().save($0.value, for: .azkar(state.activeDate, $0.key))
  }
}
