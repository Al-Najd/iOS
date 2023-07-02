//
//  DashboardFeature.swift
//
//
//  Created by Ahmed Ramy on 11/02/2022.
//



import ComposableArchitecture

import Foundation

import SwiftUI


// MARK: - Dashboard

public struct Dashboard: ReducerProtocol {
    @Dependency(\.prayersDB)
    private var prayersDB

    public init() { }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
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

    private func getReportThisWeek() {

    }

    private func getReportPreviousWeek() {

    }
}

// MARK: Dashboard.State

public extension Dashboard {
    struct State: Equatable {
        public var tipOfTheDay: String
        public var prayingStreak: String
        public var sunnahsPrayed: String
        public var azkarDoneCount: String
        public var totalFaraaidDone: String
        public var sunnahPlotData: IdentifiedArrayOf<ChartAnalyticsData>
        public var feedback: String

        public init(
            tipOfTheDay: String = "",
            prayingStreak: String = "",
            sunnahsPrayed: String = "",
            azkarDoneCount: String = "",
            totalFaraaidDone: String = "",
            sunnahPlotData: IdentifiedArrayOf<ChartAnalyticsData> = .init(uniqueElements: []),
            feedback: String = ""
        ) {
            self.tipOfTheDay = tipOfTheDay
            self.prayingStreak = prayingStreak
            self.sunnahsPrayed = sunnahsPrayed
            self.azkarDoneCount = azkarDoneCount
            self.totalFaraaidDone = totalFaraaidDone
            self.sunnahPlotData = sunnahPlotData
            self.feedback = feedback
        }

        public static func == (lhs: State, rhs: State) -> Bool {
            lhs.tipOfTheDay == rhs.tipOfTheDay
                && lhs.sunnahsPrayed == rhs.prayingStreak
                && lhs.azkarDoneCount == rhs.sunnahsPrayed
                && lhs.prayingStreak == rhs.azkarDoneCount
        }
    }
}

// MARK: Dashboard.Action

public extension Dashboard {
    enum Action: Equatable {
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

extension DayProgress {
    init(deeds: [Prayer], date: Date) {
        func getIndicator(_ count: Int, _ limit: Int) -> DayProgress.Indicator {
            let moderateThreshold = 0.25
            let goodThreshold = 0.75

            switch (Double(count) / Double(limit)) {
            case 0..<moderateThreshold:
                return .bad
            case moderateThreshold..<goodThreshold:
                return .moderate
            case goodThreshold...:
                return .good
            default:
                return .moderate
            }
        }

        let count = deeds.filter { $0.isDone }.count
        let limit = deeds.count
        self.day = date.dayName(ofStyle: .oneLetter)
        self.count = count
        self.limit = limit
        self.indicator = getIndicator(count, limit)
    }
}


typealias Analysis = (_ dateIndexedDeeds: [Date: [Prayer]]) -> Insight?

//extension Insight.Indicator {
//    static var analysis: [Analysis] {
//        let praises: [Analysis] = [
//            fajrPraiser,
//            fajrAndAishaaPraiser,
//
//        ]
//        let encourages: [Analysis] = [
//            fajrAdvisor
//        ]
//
//        let tipOfTheDay: [Analysis] = []
//
//        let danger: [Analysis] = []
//
//        return praises + encourages + tipOfTheDay + danger
//    }
//
//    static var fajrAndAishaaPraiser: (_ days: [DayDAO]) -> Insight? = { dateIndexedDeeds in
//        //    let daysWhereFajrAndAishaaArePrayed = dateIndexedDeeds.compactMap { date, deeds -> Bool in
//        //        let fajrPrayed = deeds.filter { $0.title == Deed.fajr.title }
//        //        let aishaaPrayed = deeds.filter { $0.title == Deed.aishaa.title }
//        //
//        //        return zip(fajrPrayed, aishaaPrayed).map { fajr, aishaa in
//        //            fajr.isDone && aishaa.isDone
//        //        }
//        //        .filter { $0 == false }
//        //        .count == 0
//        //    }
//        //
//        //    let didPrayFajrAndAishaa = daysWhereFajrAndAishaaArePrayed.filter { $0 == true }.count > 0
//        //    guard didPrayFajrAndAishaa else { return nil }
//        //
//        //    return .init(indicator: .praise, details: "Well Done on praying Fajr and Aishaa 👏\nIf you prayed this in Group, the reward is like you've done Qeyam Al Layil of the whole night".localized)
//        return nil
//    }
//
//    static var fajrPraiser: (_ dateIndexedDeeds: [DayDAO]) -> Insight? = { dateIndexedDeeds in
//        //    return .init(indicator: .praise, details: "Well done on praying Al Fajr on day".localized(arguments: "daysString"))
//        nil
//    }
//
//    static var fajrAdvisor: (_ dateIndexedDeeds: [DayDAO]) -> Insight? = { dateIndexedDeeds in
//        //    return .init(
//        //        indicator: .encourage,
//        //        details: "Struggling? you got this, do you want to know who can help? Al Fajr!, make sure to pray it so other deeds become easier!".localized
//        //    )
//        nil
//    }
//}

//public extension RangeProgress {
//    static let mock: [RangeProgress] = [
//        .init(
//            title: "Faraaid",
//            reports: DayProgress.mock,
//            isImproving: false,
//            insight: .init(indicator: .danger, details: "Al Faraaid are very important, make sure you don't miss them intentionally and ask for help from Allah, you got this!")
//        ),
//        .init(
//            title: "Sunnah",
//            reports: DayProgress.mock,
//            isImproving: true,
//            insight: .init(
//                indicator: .encourage,
//                details: "You did great with Sunnah last week, let's max out this week's Sunnah!"
//            )
//        ),
//        .init(
//            title: "Nafila",
//            reports: DayProgress.mock,
//            isImproving: false,
//            insight: .init(
//                indicator: .praise,
//                details: "You did Wonderful in Nafila!, I mean, wow! off the charts!, are we speaking to a 'Wali' now or what? haha, great work champ!"
//            )
//        ),
//    ]
//}

public struct DayProgress: Identifiable, Equatable {
    public var id = UUID().uuidString
    let count: Int
    let day: String
    let limit: Int
    let indicator: Indicator

    public struct Indicator {
        let color: BrandColor

        static let good: Indicator = .init(color: Color.success)
        static let moderate: Indicator = .init(color: Color.warning)
        static let bad: Indicator = .init(color: Color.danger)
    }

    public static func == (lhs: DayProgress, rhs: DayProgress) -> Bool {
        lhs.id == rhs.id
    }
}
