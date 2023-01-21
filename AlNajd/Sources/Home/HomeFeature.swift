//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import Common
import ComposableArchitecture
import Dashboard
import Entities
import Foundation
import Localization
import PrayerDetails
import PrayersClient

public struct HomeState: Equatable {
    public var prayers: IdentifiedArrayOf<ANPrayer> = []
    public var todosCount: Int = 0
    public var doneTodos: Int = 0
    public var percentage: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: .init(value: percentageValue)) ?? "%0"
    }

    public var duaa: String = ""
    var dashboard: DashboardState = .init()
    @BindableState var selectedPrayer: PrayerDetailsState?
    @BindableState var percentageValue: Float = 0
    @BindableState var date: Date = .init().startOfDay

    public init() {}
}

public enum HomeAction: BindableAction, Equatable {
    case onAppear
    case prayerDetails(PrayerDetailsAction)
    case dashboard(DashboardAction)
    case onSelecting(ANPrayer)
    case onChangingDate(Date)
    case binding(BindingAction<HomeState>)
}

public struct HomeEnvironment { public init() {} }

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
            environment: { _ in .live(.init()) }
        ),
    .init { state, action, env in
        switch action {
        case .onAppear:
            state.prayers = .init(uniqueElements: env.prayersClient.prayers(for: state.date))
            state.duaa = getRandomDuaa()
            calculateProgress(&state)
        case let .onSelecting(prayer):
            state.selectedPrayer = .init(
                prayer: prayer,
                date: state.date
            )
        case .prayerDetails(.dismiss):
            guard let selectedState = state.selectedPrayer else { return .none }
            state.prayers[id: selectedState.prayer.id] = selectedState.prayer
            state.selectedPrayer = nil
            calculateProgress(&state)
        case let .onChangingDate(date):
            state.prayers = .init(uniqueElements: env.prayersClient.prayers(for: state.date))
            calculateProgress(&state)
        case .binding:
            return Effect.
                default:
        }
        return .none
    }
).binding()

private func calculateProgress(_ state: inout HomeState) {
    state.todosCount = state.prayers.count
    let doneDeeds = state.prayers.filter { $0.isDone }
    state.doneTodos = doneDeeds.count
    state.percentageValue = Float(state.doneTodos) / Float(state.todosCount)
}

private func getRandomDuaa() -> String {
    [
        L10n.dua1,
        L10n.dua2,
        L10n.dua3,
        L10n.dua4,
        L10n.dua5,
        L10n.dua6,
        L10n.dua7,
        L10n.dua8,
        L10n.dua9,
        L10n.dua10,
        L10n.dua11,
        L10n.dua12,
        L10n.dua13,
        L10n.dua14,
        L10n.dua15,
    ].randomElement() ?? ""
}
