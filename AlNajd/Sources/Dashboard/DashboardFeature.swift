//
//  DashboardFeature.swift
//  
//
//  Created by Ahmed Ramy on 11/02/2022.
//

import ComposableArchitecture
import Entities
import Localization
import Utils
import Business
import Common
import Foundation
import SwiftUI

public struct DashboardState: Equatable {
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
		sunnahPlotData: IdentifiedArrayOf<ChartAnalyticsData> = .init(uniqueElements: [])
    ) {
		self.tipOfTheDay = tipOfTheDay
		self.prayingStreak = prayingStreak
		self.sunnahsPrayed = sunnahsPrayed
		self.azkarDoneCount = azkarDoneCount
		self.totalFaraaidDone = totalFaraaidDone
		self.sunnahPlotData = sunnahPlotData
    }

	static public func ==(lhs: DashboardState, rhs: DashboardState) -> Bool {
		return lhs.tipOfTheDay == rhs.tipOfTheDay
		&& lhs.sunnahsPrayed == rhs.prayingStreak
		&& lhs.azkarDoneCount == rhs.sunnahsPrayed
		&& lhs.prayingStreak == rhs.azkarDoneCount
	}
}

public enum DashboardAction: Equatable {
    case onAppear
	case animate(ChartAnalyticsData)
}

public struct DashboardEnvironment { public init() { } }


public let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    CoreEnvironment<DashboardEnvironment>
> { state, action, env in
    switch action {
	case .onAppear:
		state.prayingStreak = L10n.daysCount(env.prayersClient.getPrayingStreak())
		state.sunnahsPrayed = L10n.timesCount(env.prayersClient.getSunnahsPrayed())
		state.azkarDoneCount = L10n.timesCount(env.prayersClient.getAzkarDoneCount())
		state.totalFaraaidDone = L10n.timesCount(env.prayersClient.getFaraaidDone())
		state.sunnahPlotData = .init(
			uniqueElements: env.prayersClient.getSunnahPerDay().map {
				ChartAnalyticsData(date: $0, count: $1)
			}
		)

		state.sunnahPlotData.enumerated().forEach { (index: Int, data: ChartAnalyticsData) in
			withAnimation(.easeInOut(duration: 0.8 + (Double(index) * 0.05)).delay(Double(index) * 0.05)) {
				state.sunnahPlotData[id: data.id]?.animate = true
			}
		}
	case let .animate(data):
		break
    }
    return .none
}

extension Store where State == DashboardState, Action == DashboardAction {
    static let mock: Store = .init(
        initialState: .init(),
        reducer: dashboardReducer,
        environment: .live(DashboardEnvironment())
    )
}

public struct ChartAnalyticsData: Identifiable, Equatable {
	public let id: UUID = .init()
	let date: Date
	let count: Int
	var animate: Bool = true
}
