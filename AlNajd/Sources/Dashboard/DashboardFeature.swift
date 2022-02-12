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
    state.reports = report.range.map { category, dateIndexedDeeds in
      getRangeProgress(category, dateIndexedDeeds)
    }
  }
  return .none
}

func getRangeProgress(
  _ category: DeedCategory,
  _ dateIndexedDeeds: [Date: [Deed]]
) -> RangeProgress {
  RangeProgress(
    title: category.title,
    reports: dateIndexedDeeds.map { DayProgress(deeds: $0.value, date: $0.key) },
    insight: analyis(category, dateIndexedDeeds)
  )
}


var fajrPraiser: (_ category: DeedCategory, _ dateIndexedDeeds: [Date: [Deed]]) -> Insight? = { category, dateIndexedDeeds in
  guard category == .fard else { return nil }
  let daysWhereFajrIsPrayed = dateIndexedDeeds.compactMap { date, deeds -> String? in
    let doneFajrDuringRange = deeds.filter { $0 == .fajr && $0.isDone }
    guard doneFajrDuringRange.isEmpty == false else { return nil }
    
    return date.dayName(ofStyle: .full)
  }

  guard daysWhereFajrIsPrayed.isEmpty == false else { return nil }
  let daysString = daysWhereFajrIsPrayed.dropLast().joined(separator: ", ") + (daysWhereFajrIsPrayed.last ?? "")
  return .init(indicator: .praise, details: "Well done on praying Al Fajr on \(daysString)")
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
func analyis(_ category: DeedCategory, _ reports: [Date: [Deed]]) -> Insight? {
  fajrPraiser(category, reports) ?? fajrAdvisor(category, reports)
}

extension Store where State == DashboardState, Action == DashboardAction {
  static let mock: Store = .init(
    initialState: .init(reports: RangeProgress.mock),
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
