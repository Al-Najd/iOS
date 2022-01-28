//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/01/2022.
//

import Foundation
import SwiftUI
import DesignSystem
import Utils

public struct CalendarView<Day: View, Header: View, Title: View, Trailing: View>: View {
  // Injected dependencies
  private var calendar: Calendar
  @Binding private var date: Date
  private let content: (Date) -> Day
  private let trailing: (Date) -> Trailing
  private let header: (Date) -> Header
  private let title: (Date) -> Title
  
  // Constants
  private let daysInWeek = 7
  
  public init(
    calendar: Calendar,
    date: Binding<Date>,
    @ViewBuilder content: @escaping (Date) -> Day,
    @ViewBuilder trailing: @escaping (Date) -> Trailing,
    @ViewBuilder header: @escaping (Date) -> Header,
    @ViewBuilder title: @escaping (Date) -> Title
  ) {
    self.calendar = calendar
    self._date = date
    self.content = content
    self.trailing = trailing
    self.header = header
    self.title = title
  }
  
  public var body: some View {
    let month = date.startOfMonth(using: calendar)
    let days = makeDays()
    
    return LazyVGrid(
      columns: Array(repeating: GridItem(), count: daysInWeek)
    ) {
      Section(header: title(month)) {
        ForEach(days.prefix(daysInWeek), id: \.self, content: header)
        ForEach(days, id: \.self) { date in
          if calendar.isDate(date, equalTo: month, toGranularity: .month) {
            content(date)
          } else {
            trailing(date)
          }
        }
      }
    }
  }
}

// MARK: - Conformances

extension CalendarView: Equatable {
  public static func == (lhs: CalendarView<Day, Header, Title, Trailing>, rhs: CalendarView<Day, Header, Title, Trailing>) -> Bool {
    lhs.calendar == rhs.calendar && lhs.date == rhs.date
  }
}

// MARK: - Helpers

private extension CalendarView {
  func makeDays() -> [Date] {
    guard let monthInterval = calendar.dateInterval(of: .month, for: date),
          let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
          let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
    else {
      return []
    }
    
    let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
    return calendar.generateDays(for: dateInterval)
  }
}

private extension Calendar {
  func generateDates(
    for dateInterval: DateInterval,
    matching components: DateComponents
  ) -> [Date] {
    var dates = [dateInterval.start]
    
    enumerateDates(
      startingAfter: dateInterval.start,
      matching: components,
      matchingPolicy: .nextTime
    ) { date, _, stop in
      guard let date = date else { return }
      
      guard date < dateInterval.end else {
        stop = true
        return
      }
      
      dates.append(date)
    }
    
    return dates
  }
  
  func generateDays(for dateInterval: DateInterval) -> [Date] {
    generateDates(
      for: dateInterval,
         matching: dateComponents([.hour, .minute, .second], from: dateInterval.start)
    )
  }
}
// MARK: - Previews

struct CalendarView_Previews: PreviewProvider {
  @ViewBuilder
  static func generateCalendar(calendar: Calendar, date: Date) -> some View {
    CalendarView(
      calendar: calendar,
      date: .constant(date),
      content: { date in
        DateElementView(calendar: calendar, date: date, currentDate: date)
      },
      trailing: { date in
        UnfocusedDateElementView(calendar: calendar, date: date)
      },
      header: { date in
        WeekdayElementView(calendar: calendar, date)
      }, title: { date in
        MonthlyElementView(calendar, date, date)
      })
  }
  
  static var previews: some View {
    Group {
      generateCalendar(
        calendar: .init(identifier: .islamic),
        date: .now
      )
    }
  }
}
