////
////  SplashFeature.swift
////  Al Najd (iOS)
////
////  Created by Ahmed Ramy on 09/02/2022.
////
//
//import Foundation
//import ComposableArchitecture
//import Business
//import Entities
//
//struct SplashState: Equatable {
//  var canProceed: Bool = false
//}
//
//enum SplashAction: Equatable {
//  case checkIfResyncNeeded
//  case resyncWithRemote
//  case proceedToApp
//}
//
//struct SplashEnvironment {
//  
//  init() {
//    
//  }
//}
//
//let splashReducer = Reducer<
//  SplashState,
//  SplashAction,
//  SystemEnvironment<SplashEnvironment>
//> { state, action, env in
//  switch action {
//  case .checkIfResyncNeeded:
//    guard checksForResync(env).filter({ $0 == true }).isEmpty == false else {
//      return .init(
//        value: .resyncWithRemote
//      ).eraseToEffect()
//    }
//  case .resyncWithRemote:
//    env
//      .client
//      .database
//      .from("prayer-fard")
//      .select()
//  case .proceedToApp:
//    state.canProceed = true
//  }
//  
//  return .none
//}
//
//fileprivate let checksForResync: (SystemEnvironment<SplashEnvironment>) -> [Bool] = { env in
//  [
//    (env.cache().fetch([Deed].self, for: StorageKey.standard.prayers(.fard)) ?? []).isEmpty,
//    (env.cache().fetch([Deed].self, for: StorageKey.standard.prayers(.fard)) ?? []).isEmpty,
//    (env.cache().fetch([Deed].self, for: StorageKey.standard.prayers(.fard)) ?? []).isEmpty,
//    (env.cache().fetch([RepeatableDeed].self, for: StorageKey.standard.azkar(.sabah)) ?? []).isEmpty,
//    (env.cache().fetch([RepeatableDeed].self, for: StorageKey.standard.azkar(.sabah)) ?? []).isEmpty
//  ]
//}
