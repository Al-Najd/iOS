//
//  DateFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import ComposableArchitecture

struct DateState: Equatable {
  var currentDay: Date = .init()
  
  var currentWeek: [Date] {
    ((-4)...(-1)).map { currentDay.adding(.day, value: $0) }
    .appending(currentDay)
    .appending(elements: ((1)...(4)).map { currentDay.adding(.day, value: $0) })
  }
  
  var calendar: Calendar = .init(identifier: .islamic)
}

enum DateAction: Equatable {
  case onAppear
  case onChange(currentDay: Date)
}

struct DateEnvironment {}

let dateReducer = Reducer<
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
