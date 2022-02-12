//
//  CalendarView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import SwiftUI
import DesignSystem
import Entities

public struct OCalendarView: View {
  let calendar: Calendar
  @Binding var currentDate: Date
  let onChange: (Date) -> Void
  
  public init(
    _ calendar: Calendar,
    _ currentDate: Binding<Date>,
    _ onChange: @escaping (Date) -> Void
  ) {
    self.calendar = calendar
    self._currentDate = currentDate
    self.onChange = onChange
  }
  
  public var body: some View {
    VStack(spacing: .p8.adaptRatio()) {
      CalendarView(
        calendar: calendar,
        date: $currentDate,
        content: { date in
          DateElementView(
            calendar: calendar,
            date: date,
            currentDate: currentDate,
            onChange: onChange
          )
        },
        trailing: { date in
          UnfocusedDateElementView(
            calendar: calendar,
            date: date
          )
        },
        header: { date in
          WeekdayElementView(
            calendar: calendar,
            date
          )
        },
        title: { date in
          MonthlyElementView(
            calendar,
            date,
            currentDate,
            onChange
          )
        }
      )
        .equatable()
        .stay(.dark)
    }.padding(.p16.adaptRatio())
  }
}
