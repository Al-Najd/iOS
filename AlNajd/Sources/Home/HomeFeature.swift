//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import Foundation
import ComposableArchitecture
import Entities
import PrayersClient
import Common
import PrayerDetails
import Dashboard

public struct HomeState: Equatable {
    public var prayers: IdentifiedArrayOf<ANPrayer> = []
    public var date: String = ""
    public var todosCount: Int = 0
    public var doneTodos: Int = 0
    public var percentage: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: .init(value: percentageValue)) ?? "%0"
    }
    var dashboard: DashboardState = .init()
    @BindableState var selectedPrayer: PrayerDetailsState?
    @BindableState var percentageValue: Float = 0
    
    public init() { }
}

public enum HomeAction: BindableAction, Equatable {
    case onAppear
    case prayerDetails(PrayerDetailsAction)
    case dashboard(DashboardAction)
    case onSelecting(ANPrayer)
    case binding(BindingAction<HomeState>)
}

public struct HomeEnvironment { public init() { } }

public let homeReducer = Reducer<
    HomeState,
    HomeAction,
    CoreEnvironment<HomeEnvironment>
>.combine(
    dashboardReducer
        .pullback(
            state: \HomeState.dashboard,
            action: /HomeAction.dashboard,
            environment: { _ in .live(.init()) }
        ),
    prayerDetailsReducer
        .optional()
        .pullback(
            state: \HomeState.selectedPrayer,
            action: /HomeAction.prayerDetails,
            environment: { _ in .live(.init()) }),
    .init { state, action, env in
        switch action {
        case .onAppear:
            if state.prayers.isEmpty {
                state.prayers = .init(uniqueElements: env.prayersClient.prayers())
            }
            state.date = Date.now.startOfDay.format(with: [.dayOfMonth, .monthFull, .yearFull]) ?? ""
            calculateProgress(&state)
        case let .onSelecting(prayer):
            state.selectedPrayer = .init(prayer: prayer)
        case .prayerDetails(.dismiss):
            guard let selectedState = state.selectedPrayer else { return .none }
            state.prayers[id: selectedState.prayer.id] = selectedState.prayer
            state.selectedPrayer = nil
            calculateProgress(&state)
        default:
            break
        }
        return .none
    }
).binding()

fileprivate func calculateProgress(_ state: inout HomeState) {
    state.todosCount = state.prayers.count + state.prayers.map { $0.sunnah.count }.reduce(0, +)
    let doneDeeds = state.prayers.filter { $0.isDone }
    state.doneTodos = doneDeeds.count + state.prayers.flatMap { $0.sunnah.filter { $0.isDone } }.count
    state.percentageValue = Float(state.doneTodos)/Float(state.todosCount)
}
