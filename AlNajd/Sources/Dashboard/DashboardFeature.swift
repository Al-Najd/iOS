//
//  DashboardFeature.swift
//
//
//  Created by Ahmed Ramy on 11/02/2022.
//

import Business
import Common
import ComposableArchitecture
import Entities
import Foundation
import Localization
import SwiftUI
import Utils

// MARK: - DashboardState
public struct Dashboard: ReducerProtocol {
    @Dependency(\.prayersDB)
    private var prayersDB

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.prayingStreak = L10n.daysCount(prayersDB.getPrayingStreak())
                state.sunnahsPrayed = L10n.timesCount(prayersDB.getSunnahsPrayed())
                state.azkarDoneCount = L10n.timesCount(prayersDB.getAzkarDoneCount())
                state.totalFaraaidDone = L10n.timesCount(prayersDB.getFaraaidDone())
                state.sunnahPlotData = .init(
                    uniqueElements: prayersDB.getSunnahPerDay().map {
                        ChartAnalyticsData(date: $0, count: $1)
                    })

                state.sunnahPlotData.enumerated().forEach { (index: Int, data: ChartAnalyticsData) in
                    withAnimation(.easeInOut(duration: 0.8 + (Double(index) * 0.05)).delay(Double(index) * 0.05)) {
                        state.sunnahPlotData[id: data.id]?.animate = true
                    }
                }
            default:
                break
            }
            return .none
        }
    }
}

extension Dashboard {
    public struct State: Equatable {
        public var tipOfTheDay: String
        public var prayingStreak: String
        public var sunnahsPrayed: String
        public var azkarDoneCount: String
        public var totalFaraaidDone: String
        public var sunnahPlotData: IdentifiedArrayOf<ChartAnalyticsData>

        public init(
            tipOfTheDay: String = "",
            prayingStreak: String = "",
            sunnahsPrayed: String = "",
            azkarDoneCount: String = "",
            totalFaraaidDone: String = "",
            sunnahPlotData: IdentifiedArrayOf<ChartAnalyticsData> = .init(uniqueElements: [])) {
                self.tipOfTheDay = tipOfTheDay
                self.prayingStreak = prayingStreak
                self.sunnahsPrayed = sunnahsPrayed
                self.azkarDoneCount = azkarDoneCount
                self.totalFaraaidDone = totalFaraaidDone
                self.sunnahPlotData = sunnahPlotData
            }

        public static func == (lhs: State, rhs: State) -> Bool {
            lhs.tipOfTheDay == rhs.tipOfTheDay
            && lhs.sunnahsPrayed == rhs.prayingStreak
            && lhs.azkarDoneCount == rhs.sunnahsPrayed
            && lhs.prayingStreak == rhs.azkarDoneCount
        }
    }
}

// MARK: - DashboardAction
extension Dashboard {
    public enum Action: Equatable {
        case onAppear
        case animate(ChartAnalyticsData)
    }
}

// MARK: - ChartAnalyticsData

public struct ChartAnalyticsData: Identifiable, Equatable {
    public let id: UUID = .init()
    let date: Date
    let count: Int
    var animate = true
}
