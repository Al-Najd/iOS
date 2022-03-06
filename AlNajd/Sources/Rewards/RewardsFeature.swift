//
//  RewardsFeature.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import Foundation
import ComposableArchitecture
import Business
import Entities
import Common
import Date

public struct RewardsState: Equatable {
  public var activeDate: Date = .init()
  public var dateState: DateState
  public var prayers: [DeedCategory: [Deed]] = [
    .fard: .faraaid,
    .sunnah: .sunnah,
    .nafila: .nafila
  ]
  
  public var azkar: [AzkarCategory: [RepeatableDeed]] = [
    .sabah: .sabah,
    .masaa: .masaa
  ]
  
  public init(activeDate: Date = .init(), dateState: DateState, prayers: [DeedCategory : [Deed]] = [
    .fard: .faraaid,
    .sunnah: .sunnah,
    .nafila: .nafila
  ], azkar: [AzkarCategory : [RepeatableDeed]] = [
    .sabah: .sabah,
    .masaa: .masaa
  ]) {
    self.activeDate = activeDate
    self.dateState = dateState
    self.prayers = prayers
    self.azkar = azkar
  }
}

public enum RewardsAction: Equatable {
  case onAppear
  case date(DateAction)
  case onDoingDeed(Deed)
  case onUndoingDeed(Deed)
  case onDoingRepeatableDeed(RepeatableDeed)
  case onUndoingRepeatableDeed(RepeatableDeed)
  case onQuickFinishRepeatableDeed(RepeatableDeed)
}

public struct RewardsEnvironment { public init() { } }

public let rewardsReducer = Reducer<
  RewardsState,
  RewardsAction,
  CoreEnvironment<RewardsEnvironment>
> { state, action, env in
  switch action {
  case .onAppear:
    break
  case let .onDoingDeed(deed):
    state.prayers[deed.category]?.findAndReplaceElseAppend(with: deed)
  case let .onUndoingDeed(deed):
    state.prayers[deed.category]?.findAndReplaceElseAppend(with: deed)
  case let .onDoingRepeatableDeed(repeatableDeed: deed):
    state.azkar[deed.category]?.findAndReplaceElseAppend(with: deed)
  case let .onUndoingRepeatableDeed(repeatableDeed: deed):
    state.azkar[deed.category]?.findAndReplaceElseAppend(with: deed)
  case let .onQuickFinishRepeatableDeed(repeatableDeed: deed):
    state.azkar[deed.category]?.findAndReplaceElseAppend(with: deed)
    case let .date(.onChange(date)):
      state.activeDate = date
    default:
      break
  }
  
  return .none
}.debug()

fileprivate func cachePrayerRewards(_ state: RewardsState, _ env: CoreEnvironment<RewardsEnvironment>) {
  state.prayers.forEach {
    env.cache().save($0.value.filter { $0.isDone }, for: .prayersRewards(state.activeDate, $0.key))
  }
}

fileprivate func cacheAzkarRewards(_ state: RewardsState, _ env: CoreEnvironment<RewardsEnvironment>) {
  state.azkar.forEach {
    env.cache().save($0.value.filter { $0.isDone }, for: .azkarRewards(state.activeDate, $0.key))
  }
}

public extension Store where State == RewardsState, Action == RewardsAction {
  static let dev: (
    _ prayers: [Deed],
    _ azkar: [RepeatableDeed]
  ) -> (Store<RewardsState, RewardsAction>) = { prayers, azkar in
    let env = CoreEnvironment.live(RewardsEnvironment())
    env.cache().save(
      prayers,
      for: .prayers(
        .now,
        .fard
      )
    )
    
    env.cache().save(
      azkar,
      for: .azkar(
        .now,
        .sabah
      )
    )
    
    return .init(
      initialState: .init(dateState: .init()),
      reducer: rewardsReducer,
      environment: env
    )
  }
}
