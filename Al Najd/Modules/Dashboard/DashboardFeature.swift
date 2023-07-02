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
    @Dependency(\.prayersService)
    private var service

    public init() { }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            state.prayingStreak = L10n.daysCount(service.getPrayingStreak())
            state.sunnahsPrayed = L10n.timesCount(service.getSunnahsPrayed())
            state.azkarDoneCount = L10n.timesCount(service.getAzkarDoneCount())
            state.totalFaraaidDone = L10n.timesCount(service.getFaraaidDone())
            state.sunnahPlotData = .init(
                uniqueElements: service.getSunnahPerDay().map {
                    ChartAnalyticsData(date: $0, count: $1)
                })

            state.sunnahPlotData.enumerated().forEach { (index: Int, data: ChartAnalyticsData) in
                withAnimation(.easeInOut(duration: 0.8 + (Double(index) * 0.05)).delay(Double(index) * 0.05)) {
                    state.sunnahPlotData[id: data.id]?.animate = true
                }
            }

            let report = analyize(currentRangeReport: getCurrentWeekReport(), previousRangeReport: getLastWeekReport())
            state.report = report
            state.feedback = report.insight?.details ?? L10n.doingGreat
        default:
            break
        }
        return .none
    }

    let noEnoughDataMessageBank = [
        L10n.dashboardNotEnoughDataMessage1,
        L10n.dashboardNotEnoughDataMessage2,
        L10n.dashboardNotEnoughDataMessage3
    ]

    func getCurrentWeekReport() -> Report.Range {
        let days = service.getCurrentWeek()
        let ranges = days.reduce(into: [Date: [Prayer]]()) { dictionary, day in
            dictionary[day.date] = day.prayers.elements
        }

        return .init(ranges: ranges)
    }

    func getLastWeekReport() -> Report.Range {
        let days = service.getPreviousWeek()
        let ranges = days.reduce(into: [Date: [Prayer]]()) { dictionary, day in
            dictionary[day.date] = day.prayers.elements
        }

        return .init(ranges: ranges)
    }

    func analyize(
        currentRangeReport: Report.Range,
        previousRangeReport: Report.Range? = nil
    ) -> RangeProgress {
        if let previousRangeReport = previousRangeReport {
            let prev = getRangeProgress(previousRangeReport.range)
            let current = getRangeProgress(currentRangeReport.range)

            return current.changeImprovement(to: current.score >= prev.score)
        } else {
            return getRangeProgress(currentRangeReport.range)
                .changeImprovement(to: true)
        }
    }

    func getRangeProgress(_ range: PrayersRange) -> RangeProgress {
        let countOfDoneDuringRange =  range.values.flatMap { $0 }.filter { $0.isDone }.count
        let rangeNumberOfDays = range.count
        let reports = countOfDoneDuringRange >= rangeNumberOfDays
        ? range.map { (date: $0.key, deeds: $0.value) }.sorted(by: { $0.date > $1.date }).map { DayProgress(deeds: $0.deeds, date: $0.date) }
        : []

        let insight: Insight? = reports.isEmpty ? .init(
            indicator: .encourage,
            details: noEnoughDataMessageBank.randomElement() ?? noEnoughDataMessageBank[0]
        ) : analyize(range)

        return RangeProgress(
            title: L10n.faraaid,
            reports: reports,
            insight: insight,
            score: countOfDoneDuringRange
        )
    }

    static var fajrAndAishaaPraiser: Analysis = { dateIndexedDeeds in
        let daysWhereFajrAndAishaaArePrayed = dateIndexedDeeds.compactMap { date, deeds -> Bool in
            let fajrPrayed = deeds.filter { $0.name == "fajr" }
            let aishaaPrayed = deeds.filter { $0.name == "aishaa" }

            return zip(fajrPrayed, aishaaPrayed).map { fajr, aishaa in
                fajr.isDone && aishaa.isDone
            }
            .filter { $0 == false }
            .count == 0
        }

        let didPrayFajrAndAishaa = daysWhereFajrAndAishaaArePrayed.filter { $0 == true }.count > 0
        guard didPrayFajrAndAishaa else { return nil }

        return .init(indicator: .praise, details: L10n.dashboardIndicatorFajrAndAishaaPraiserMessage)
    }

    static var fajrPraiser: Analysis = { reports in
        guard let dayName = reports.first(where: { (key: Date, prayers: [Prayer]) in
            prayers.first(where: { $0.name == "fajr" }) != nil
        })?.key.dayName(ofStyle: .full) else {
            Log.error("Couldn't get day's name when praising for Fajr")
            return .init(indicator: .praise, details: L10n.dashboardIndicatorFajrPraiserMessage(""))
        }

        return .init(indicator: .praise, details: L10n.dashboardIndicatorFajrPraiserMessage(dayName))
    }

    static var fajrAdvisor: Analysis = { dateIndexedDeeds in
        return .init(
            indicator: .encourage,
            details: L10n.dashboardIndicatorFajrAdvisorMessage
        )
    }

    func analyize(_ reports: PrayersRange) -> Insight? {
        Insight.Indicator.analysis.compactMap { $0(reports) }.first
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
        public var report: RangeProgress

        public init(
            tipOfTheDay: String = "",
            prayingStreak: String = "",
            sunnahsPrayed: String = "",
            azkarDoneCount: String = "",
            totalFaraaidDone: String = "",
            sunnahPlotData: IdentifiedArrayOf<ChartAnalyticsData> = .init(uniqueElements: []),
            feedback: String = "",
            report: RangeProgress = .init(title: "", reports: [])
        ) {
            self.tipOfTheDay = tipOfTheDay
            self.prayingStreak = prayingStreak
            self.sunnahsPrayed = sunnahsPrayed
            self.azkarDoneCount = azkarDoneCount
            self.totalFaraaidDone = totalFaraaidDone
            self.sunnahPlotData = sunnahPlotData
            self.feedback = feedback
            self.report = report
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

public struct DayProgress: Identifiable, Equatable {
    public var id = UUID().uuidString
    let count: Int
    let day: String
    let limit: Int
    let indicator: Indicator

    public struct Indicator {
        let fill: Color
        let stroke: Color
        let shadow: Color

        static let good: Indicator = .init(fill: .mono.offwhite, stroke: .primaryBluberry, shadow: .shadowBlueperry)
        static let moderate: Indicator = .init(fill: .tangerinePrimary, stroke: .tangerineLight, shadow: .shadowTangerine)
        static let bad: Indicator = .init(fill: .cherryPrimary, stroke: .cherryLight, shadow: .shadowCherry)
    }

    public static func == (lhs: DayProgress, rhs: DayProgress) -> Bool {
        lhs.id == rhs.id
    }
}

extension Insight.Indicator {
    static var analysis: [Analysis] {
        let praises: [Analysis] = [
            Dashboard.fajrPraiser,
            Dashboard.fajrAndAishaaPraiser
        ]

        let encourages: [Analysis] = [Dashboard.fajrAdvisor]
        let tipOfTheDay: [Analysis] = []
        let danger: [Analysis] = []

        return praises + encourages + tipOfTheDay + danger
    }
}
