//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import ComposableArchitecture
import Foundation

public struct Home: Reducer {
    @Dependency(\.prayersService)
    private var prayersDB

    public init() { }

    public struct State: Equatable {
        public var prayers: IdentifiedArrayOf<Prayer> = []
        public var nafila: IdentifiedArrayOf<Nafila> = []
        public var todosCount = 0
        public var doneTodos = 0
        public var percentage: String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            return formatter.string(from: .init(value: percentageValue)) ?? "%0"
        }

        public var duaa = ""
        @BindingState var selectedPrayer: PrayerDetails.State?
        @BindingState var selectedNafila: NafilaDetails.State?
        @BindingState var percentageValue: Float = 0
        @BindingState var date: Date = .init().startOfDay

        public init() { }
    }

    public enum Action: BindableAction {
        case onAppear
        case prayerDetails(PrayerDetails.Action)
        case nafilaDetails(NafilaDetails.Action)
        case onSelecting(Prayer)
        case onSelectingNafila(Nafila)
        case binding(BindingAction<State>)
    }

    public var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .onAppear:
                state.prayers = .init(uniqueElements: prayersDB.prayers(for: state.date))
                state.nafila = .init(uniqueElements: prayersDB.nafila(for: state.date))
                state.duaa = getRandomDuaa()
                calculateProgress(&state)
            case .onSelecting(let prayer):
                state.selectedPrayer = .init(
                    prayer: prayer,
                    date: state.date)
            case .onSelectingNafila(let nafila):
                state.selectedNafila = .init(
                    nafila: nafila,
                    date: state.date)
            case .prayerDetails(.dismiss):
                guard let selectedState = state.selectedPrayer else { return .none }
                state.prayers[id: selectedState.prayer.id] = selectedState.prayer
                state.selectedPrayer = nil
                calculateProgress(&state)
            case .nafilaDetails(.dismiss):
                guard let selectedState = state.selectedNafila else { return .none }
                state.nafila[id: selectedState.nafila.id] = selectedState.nafila
                state.selectedNafila = nil
//                calculateProgress(&state)
            case .binding(\.$date):
                state.prayers = .init(uniqueElements: prayersDB.prayers(for: state.date))
                calculateProgress(&state)
                return .none
            default:
                return .none
            }

            return .none
        }
        .ifLet(\.selectedPrayer, action: /Action.prayerDetails) {
            PrayerDetails()
        }
        .ifLet(\.selectedNafila, action: /Action.nafilaDetails) {
            NafilaDetails()
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
