//
//  RewardsFeature.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import Foundation
import ComposableArchitecture
import Business

struct RewardsState: Equatable {
  var activeDate: Date = .now
  var prayers: [DeedCategory: [Deed]] = [
    .fard: [],
    .sunnah: [],
    .nafila: []
  ]
  
  var azkar: [AzkarCategory: [RepeatableDeed]] = [
    .sabah: [],
    .masaa: []
  ]
}

enum RewardsAction: Equatable {
  case onAppear
}

struct RewardsEnvironment {}

let rewardsReducer = Reducer<
  RewardsState,
  RewardsAction,
  SystemEnvironment<RewardsEnvironment>
> { state, action, env in
  switch action {
  case .onAppear:
    state.prayers = [
      .fard: getPrayersRewardsFromCache(env.cache(), state.activeDate, .fard) ?? [],
      .sunnah: getPrayersRewardsFromCache(env.cache(), state.activeDate, .sunnah) ?? [],
      .nafila: getPrayersRewardsFromCache(env.cache(), state.activeDate, .nafila) ?? []
    ]
    
    state.azkar = [
      .sabah: getAzkarRewardsFromCache(env.cache(), state.activeDate, .sabah) ?? [],
      .masaa: getAzkarRewardsFromCache(env.cache(), state.activeDate, .masaa) ?? []
    ]
  }
  
  return .none
}

extension Store where State == RewardsState, Action == RewardsAction {
  static let main: Store<State, Action>  = .init(
    initialState: .init(),
    reducer: rewardsReducer,
    environment: .live(RewardsEnvironment())
  )
  
  static let dev: (
    _ prayers: [Deed],
    _ azkar: [RepeatableDeed]
  ) -> (Store<RewardsState, RewardsAction>) = { prayers, azkar in
    let env = SystemEnvironment.live(RewardsEnvironment())
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
      initialState: .init(),
      reducer: rewardsReducer,
      environment: env
    )
  }
}
