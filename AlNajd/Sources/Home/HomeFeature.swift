//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import ComposableArchitecture
import Entities
import PrayersClient
import Common
import TCACoordinators

//public struct RootState: Equatable {
//    let home: HomeState
//    let prayerDetailsState: PrayerDetailsState
//}
//
//public enum RootAction: Equatable {
//    case home(HomeState)
//    case prayerDetails(PrayerDetailsState)
//}
//
//public struct RootEnvironment { public init() { } }
//
//public let rootReducer = Reducer<
//    RootState,
//    RootAction,
//    CoreEnvironment<Void>
//>.combine(
//    homeReducer
//        .pullback(
//            state: /RootState.home,
//            action: /RootAction.home,
//            environment: .live(())
//        )
//)

//public struct PrayerDetailsState: Equatable {
//    let prayer: ANPrayer
//}
//
//public struct HomeState: Equatable {
//    public var prayers: [ANPrayer]
//    
//    public init(prayers: [ANPrayer] = .faraaid) {
//        self.prayers = prayers
//    }
//}
//
//public enum HomeAction: Equatable {
//    case onSelecting(ANPrayer)
//}
//
//public let homeReducer = Reducer<
//    HomeState,
//    HomeAction,
//    CoreEnvironment<Void>
//> { state, action, env in
//    return .none
//}
//
//struct CoordinatorState: Equatable, IndexedRouterState {
//    var routes: [Route<HomeState>]
//}
//
//enum CoordinatorAction: Equatable, IndexedRouterAction {
//    case route(Int, action: RootAction)
//    case updateRoutes([Route<HomeState>])
//}
//
//let coordinatorReducer: Reducer<CoordinatorState, CoordinatorAction, Void> = rootReducer
//    .forEachIndexedRoute(environment: { _ in })
//    .withRouteReducer(
//        Reducer<CoordinatorState, CoordinatorAction, Void> { state, action, environment in
//            switch action {
//            case let .routeAction(_, action: .onSelecting(prayer)):
//                state.routes.presentCover(.prayerDetails(.init()))
//            }
//        }
//    )
