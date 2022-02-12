//
//  DashboardFeature.swift
//  
//
//  Created by Ahmed Ramy on 11/02/2022.
//

// TODO: - Check for possible insight
// TODO: - Get & Compare Two Frames and deduce improvement
// TODO: - Check for possible insight between two frames

import ComposableArchitecture
import Entities
import Localization
import Utils

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
    case seed(Report.Range)
}

public struct DashboardEnvironment { public init() { } }


public let dashboardReducer = Reducer<
    DashboardState,
    DashboardAction,
    DashboardEnvironment
> { state, action, env in
    switch action {
    case let .seed(report):
        state.reports = analyize(report)
    }
    return .none
}

func analyize(_ report: Report.Range) -> [RangeProgress] {
    report.ranges.sorted(by: {
        $0.key.rawValue > $1.key.rawValue
    }).compactMap { category, dateIndexedDeeds in
        getRangeProgress(category, dateIndexedDeeds)
    }
}

let noEnoughDataMessageBank = [
    "How about we make it a challenge to us to populate this with great deeds? wouldn't that be awesome?".localized,
    "Wouldn't it be awesome if we had a week's worth of awesome deeds to display here? let's nail it this week!".localized,
    "Hmm, sad, but we still have a chance! let's pray hard this week!".localized
]

func getRangeProgress(
    _ category: DeedCategory,
    _ dateIndexedDeeds: [Date: [Deed]]
) -> RangeProgress {
    let countOfDoneDuringRange =  dateIndexedDeeds.values.flatMap { $0 }.filter { $0.isDone }.count
    let rangeNumberOfDays = dateIndexedDeeds.count
    let reports = countOfDoneDuringRange >= rangeNumberOfDays
    ? dateIndexedDeeds.map { (date: $0.key, deeds: $0.value) }.sorted(by: { $0.date > $1.date }).map { DayProgress(deeds: $0.deeds, date: $0.date) }
    : []
    
    let insight: Insight? = reports.isEmpty ? .init(
        indicator: .encourage,
        details: noEnoughDataMessageBank.randomElement() ?? noEnoughDataMessageBank[0]
    ) : analyize(category, dateIndexedDeeds)
    
    return RangeProgress(
        title: category.title,
        reports: reports,
        insight: insight
    )
}


var fajrPraiser: (_ category: DeedCategory, _ dateIndexedDeeds: [Date: [Deed]]) -> Insight? = { category, dateIndexedDeeds in
    guard category == .fard else { return nil }
    let daysWhereFajrIsPrayed = dateIndexedDeeds.compactMap { date, deeds -> String? in
        let didDoFajr = deeds.first { $0.isDone == true && $0 == .fajr } != nil
        guard didDoFajr == true else { return nil }
        
        return date.dayName(ofStyle: .full)
    }
    
    guard daysWhereFajrIsPrayed.isEmpty == false else { return nil }
    let daysString = daysWhereFajrIsPrayed
        .dropLast()
        .joined(separator: ", ")
    + ", and day".localized(arguments: daysWhereFajrIsPrayed.last ?? "")
    
    return .init(indicator: .praise, details: "Well done on praying Al Fajr on day".localized(arguments: daysString))
}

var fajrAdvisor: (_ category: DeedCategory, _ dateIndexedDeeds: [Date: [Deed]]) -> Insight? = { category, dateIndexedDeeds in
    guard category == .fard else { return nil }
    
    let allDeeds = dateIndexedDeeds.values.flatMap { $0 }
    // Make sure that total faraaid done doesn't exceed 10
    guard allDeeds.filter({ $0.isDone }).count <= 10 else { return nil }
    // Make sure that total fajr prayed doesn't exceed 1
    guard allDeeds.filter({ $0 == .fajr && $0.isDone }).count <= 1 else { return nil }
    
    return .init(
        indicator: .encourage,
        details: "Struggling? you got this, do you want to know who can help? Al Fajr!, make sure to pray it so other deeds become easier!".localized
    )
}

// IDEAS
// who prays all sunnah, gets a home in Jannah (Encourage)
// Qeyam Al Layl can be done with a prayer after Al Aishaa of 7 verses, if you did Wetr, u also did qyam al layl
func analyize(_ category: DeedCategory, _ reports: [Date: [Deed]]) -> Insight? {
    Insight.Indicator.analysis.compactMap { $0(category, reports) }.first
}

extension Store where State == DashboardState, Action == DashboardAction {
    static let mock: Store = .init(
        initialState: .init(reports: RangeProgress.mock),
        reducer: dashboardReducer,
        environment: DashboardEnvironment()
    )
    
    static let noReports: Store = .init(
        initialState: .init(
            reports: RangeProgress.mock.map {
                RangeProgress(title: $0.title, reports: [], isImproving: $0.isImproving, insight: $0.insight)
            }
        ),
        reducer: dashboardReducer,
        environment: DashboardEnvironment()
    )
}

extension DayProgress {
    init(deeds: [Deed], date: Date) {
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


typealias Analysis = (_ category: DeedCategory, _ dateIndexedDeeds: [Date: [Deed]]) -> Insight?
extension Insight.Indicator {
    static var analysis: [Analysis] {
        let praises: [Analysis] = [fajrPraiser]
        let encourages: [Analysis] = [fajrAdvisor]
        let tipOfTheDay: [Analysis] = []
        let danger: [Analysis] = []
        
        return praises + encourages + tipOfTheDay + danger
    }
}

extension Deed: Changeable {}
extension RangeProgress: Changeable {}
