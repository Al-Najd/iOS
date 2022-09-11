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

public struct DashboardState: Equatable {
    public var tipOfTheDay: String
    public var reports: [RangeProgress]
    
    public init(
        tipOfTheDay: String = "",
        reports: [RangeProgress] = []
    ) {
        self.reports = reports
        self.tipOfTheDay = tipOfTheDay
    }
}

public enum DashboardAction: Equatable {
    case onAppear
    case populate(with: [RangeProgress])
}

public struct DashboardEnvironment { public init() { } }


public let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    CoreEnvironment<DashboardEnvironment>
> { state, action, env in
    switch action {
        case .onAppear:
        state.reports = [
            analyize(
                currentRangeReport: getWeeklyReport(from: .now, env),
                previousRangeReport: getWeeklyReport(from: .now.adding(.day, value: -7), env)
            )
        ]
    case let .populate(with: ranges):
        state.reports = ranges
    }
    return .none
}

func analyize(
    currentRangeReport: Report.Range,
    previousRangeReport: Report.Range
) -> RangeProgress {
    let previous = getRangeProgress(previousRangeReport.ranges)
    let current = getRangeProgress(currentRangeReport.ranges)
    return current.changeImprovement(to: current.score >= previous.score)
}

func getWeeklyReport(from date: Date, _ env: CoreEnvironment<DashboardEnvironment>) -> Report.Range {
    .init(ranges: date.currentWeek.reduce(into: [Date: [ANPrayer]]()) { current, next in
        current[next] = env.prayersClient.prayers(for: next)
    })
}

let noEnoughDataMessageBank = [
    "How about we make it a challenge to us to populate this with great deeds? wouldn't that be awesome?".localized,
    "Wouldn't it be awesome if we had a week's worth of awesome deeds to display here? let's nail it this week!".localized,
    "Hmm, sad, but we still have a chance! let's pray hard this week!".localized
]

func getRangeProgress(
    _ dateIndexedDeeds: [Date: [ANPrayer]]
) -> RangeProgress {
    let countOfDoneDuringRange =  dateIndexedDeeds.values.flatMap { $0 }.filter { $0.isDone }.count
    let reports = dateIndexedDeeds.map { DayProgress(deeds: $0.value, date: $0.key) }
    
    let insight: Insight? = analyize(dateIndexedDeeds)
    
    return RangeProgress(
        title: "Faraaid".localized,
        reports: reports,
        insight: insight,
        score: countOfDoneDuringRange
    )
}

var fajrAndAishaaPraiser: (_ dateIndexedDeeds: [Date: [ANPrayer]]) -> Insight? = { dateIndexedDeeds in
//    let daysWhereFajrAndAishaaArePrayed = dateIndexedDeeds.compactMap { date, deeds -> Bool in
//        let fajrPrayed = deeds.filter { $0.title == Deed.fajr.title }
//        let aishaaPrayed = deeds.filter { $0.title == Deed.aishaa.title }
//
//        return zip(fajrPrayed, aishaaPrayed).map { fajr, aishaa in
//            fajr.isDone && aishaa.isDone
//        }
//        .filter { $0 == false }
//        .count == 0
//    }
//
//    let didPrayFajrAndAishaa = daysWhereFajrAndAishaaArePrayed.filter { $0 == true }.count > 0
//    guard didPrayFajrAndAishaa else { return nil }
//
//    return .init(indicator: .praise, details: "Well Done on praying Fajr and Aishaa 👏\nIf you prayed this in Group, the reward is like you've done Qeyam Al Layil of the whole night".localized)
    return nil
}

var fajrPraiser: (_ dateIndexedDeeds: [Date: [ANPrayer]]) -> Insight? = { dateIndexedDeeds in
//    return .init(indicator: .praise, details: "Well done on praying Al Fajr on day".localized(arguments: "daysString"))
    nil
}

var fajrAdvisor: (_ dateIndexedDeeds: [Date: [ANPrayer]]) -> Insight? = { dateIndexedDeeds in
//    return .init(
//        indicator: .encourage,
//        details: "Struggling? you got this, do you want to know who can help? Al Fajr!, make sure to pray it so other deeds become easier!".localized
//    )
    nil
}

func analyize(_ reports: [Date: [ANPrayer]]) -> Insight? {
    Insight.Indicator.analysis.compactMap { $0(reports) }.first
}

extension Store where State == DashboardState, Action == DashboardAction {
    static let mock: Store = .init(
        initialState: .init(
            reports: RangeProgress.mock
        ),
        reducer: dashboardReducer,
        environment: .live(DashboardEnvironment())
    )
    
    static let noReports: Store = .init(
        initialState: .init(
            reports: RangeProgress.mock.map {
                RangeProgress(title: $0.title, reports: [], isImproving: $0.isImproving, insight: $0.insight)
            }
        ),
        reducer: dashboardReducer,
        environment: .live(DashboardEnvironment())
    )
}

extension DayProgress {
    init(deeds: [ANPrayer], date: Date) {
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


typealias Analysis = (_ dateIndexedDeeds: [Date: [ANPrayer]]) -> Insight?
extension Insight.Indicator {
    static var analysis: [Analysis] {
        let praises: [Analysis] = [fajrPraiser, fajrAndAishaaPraiser]
        let encourages: [Analysis] = [fajrAdvisor]
        let tipOfTheDay: [Analysis] = []
        let danger: [Analysis] = []
        
        return praises + encourages + tipOfTheDay + danger
    }
}

extension Deed: Changeable {}
extension RangeProgress: Changeable {}
