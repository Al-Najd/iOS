//
//  DateFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import ComposableArchitecture
import Utils

public struct DateState: Equatable {
  public var currentDay: Date = .init()
  
  public var currentWeek: [Date] {
    ((-4)...(-1)).map { currentDay.adding(.day, value: $0) }
    .appending(currentDay)
    .appending(elements: ((1)...(4)).map { currentDay.adding(.day, value: $0) })
  }
  
  public var calendar: Calendar = .init(identifier: .islamic)
  
  public init(
    currentDay: Date = .init(),
    calendar: Calendar = .init(identifier: .islamic)
  ) {
    self.currentDay = currentDay
    self.calendar = calendar
  }
}

public enum DateAction: Equatable {
  case onAppear
  case onChange(currentDay: Date)
}

public struct DateEnvironment { public init() { } }

public let dateReducer = Reducer<
  DateState,
  DateAction,
  DateEnvironment
> { state, action, env in
  switch action {
  case .onAppear:
    state.currentDay = .now
  case .onChange(let currentDay):
    guard !currentDay.isInFuture else { return .none }
    state.currentDay = currentDay
  }
  
  return .none
}
