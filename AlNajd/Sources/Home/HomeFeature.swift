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

public struct Home: ReducerProtocol {
    @Dependency(\.prayersDB)
    private var prayersDB

    public struct State: Equatable {
        public var prayers: IdentifiedArrayOf<ANPrayer> = []
        public var todosCount = 0
        public var doneTodos = 0
        public var percentage: String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            return formatter.string(from: .init(value: percentageValue)) ?? "%0"
        }

        public var duaa = ""
        var dashboard: DashboardState = .init()
        @BindingState var selectedPrayer: PrayerDetailsState?
        @BindingState var percentageValue: Float = 0
        @BindingState var date: Date = .init().startOfDay

        public init() { }
    }

    public enum Action: BindableAction {
        case onAppear
        case prayerDetails(PrayerDetailsAction)
        case dashboard(DashboardAction)
        case onSelecting(ANPrayer)
        case binding(BindingAction<State>)
    }

    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .onAppear:
                state.prayers = .init(uniqueElements: prayersDB.prayers(for: state.date))
                state.duaa = getRandomDuaa()
                calculateProgress(&state)
            case .onSelecting(let prayer):
                state.selectedPrayer = .init(
                    prayer: prayer,
                    date: state.date)
            case .prayerDetails(.dismiss):
                guard let selectedState = state.selectedPrayer else { return .none }
                state.prayers[id: selectedState.prayer.id] = selectedState.prayer
                state.selectedPrayer = nil
                calculateProgress(&state)
            case .binding(\.$date):
                state.prayers = .init(uniqueElements: prayersDB.prayers(for: state.date))
                calculateProgress(&state)
                return .none
            default:
                return .none
            }

            return .none
        }
    }

    private func calculateProgress(_ state: inout State) {
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
}

// public let homeReducer = Reducer<
//    HomeState,
//    HomeAction,
//    CoreEnvironment<HomeEnvironment>
// >.combine(
//    dashboardReducer
//        .pullback(
//            state: \HomeState.dashboard,
//            action: /HomeAction.dashboard,
//            environment: { _ in .live(.init()) }
//        ),
//    prayerDetailsReducer
//        .optional()
//        .pullback(
//            state: \HomeState.selectedPrayer,
//            action: /HomeAction.prayerDetails,
//            environment: { _ in .live(.init()) }),
//    .init { state, action, env in
//        switch action {
//        case .onAppear:
//        case let .onSelecting(prayer):

//        case .prayerDetails(.dismiss):

//		case let .onChangingDate(date):
//			state.prayers = .init(uniqueElements: env.prayersClient.prayers(for: state.date))
//			calculateProgress(&state)
//        case .binding:
//            return Effect.
//        default:
//            break
//        }
//        return .none
//    }
// ).binding()
