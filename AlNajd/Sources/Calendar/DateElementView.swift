//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/01/2022.
//

import SwiftUI
import DesignSystem
import Foundation
import Utils

public struct DateElementView: View {
  var calendar: Calendar
  let date: Date
  let dayFormatter: DateFormatter
  let currentDate: Date
  let onChange: (Date) -> Void
  
  public init(
    calendar: Calendar,
    date: Date,
    currentDate: Date,
    onChange: @escaping (Date) -> Void = { _ in }
  ) {
    self.calendar = calendar
    self.currentDate = currentDate
    self.date = date
    self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
    self.onChange = onChange
  }
  
  var coloring: (background: Color, title: Color) {
    determineColor(
      timing: .init(date),
      selection: .init(currentDate, date: date)
    )
  }
  
  
  public var body: some View {
    Button(
      action: {
        withAnimation {
          onChange(date)
        }
      }
    ) {
      Text("00")
        .foregroundColor(.clear)
        .padding(.p8.adaptV(min: .p4, max: .p16))
        .background(coloring.background)
        .cornerRadius(.r8.adaptRatio())
        .accessibilityHidden(true)
        .if(date.isInFuture) {
          $0.overlay(
            Image(systemName: "lock")
              .scaledFont(.pHeadline, .bold)
              .foregroundColor(coloring.title)
            )
        }.if(!date.isInFuture) {
          $0.overlay(
            Text(dayFormatter.string(from: date))
              .scaledFont(.pHeadline, .bold)
              .foregroundColor(coloring.title)
          )
        }
    }
  }
}

extension DateElementView {
  enum DaySelection {
    case selected
    case notSelected
    
    init(_ selectedDate: Date, date: Date) {
      self = selectedDate == date ? .selected : .notSelected
    }
  }
  
  enum DayTiming {
    case today
    case past
    case future
    
    init(_ date: Date) {
      self = date.isInFuture ? .future : date.isInToday ? .today : .past
    }
  }
  
  private func determineColor(
    timing: DayTiming,
    selection: DaySelection
  ) -> (
    background: Color,
    title: Color
  ) {
    switch (selection, timing) {
    case (_, .future):
      return (
        .mono.placeholder,
        .mono.offwhite
      )
    case (.selected, .today):
      return (.success.light, .mono.offblack)
    case (.selected, .past):
      return (.success.default, .mono.offwhite)
    case (.notSelected, .today):
      return (.secondary.default, .mono.offblack)
    case (.notSelected, .past):
      return (
        .primary.default,
        .mono.offwhite
      )
    }
  }
}
