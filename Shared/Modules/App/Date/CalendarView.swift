//
//  CalendarView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

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

private extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

private extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}

// MARK: - Previews

#if DEBUG
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//          OCalendarView(
//            selectedDate: .now,
//            calendar: .init(identifier: .islamicUmmAlQura)
//          )
          EmptyView()
        }
    }
}
#endif

struct OCalendarView: View {
  private let monthFormatter: DateFormatter
  private let weekDayFormatter: DateFormatter
  
  var viewStore: ViewStore<DateState, DateAction>
  
  init(
    _ viewStore: ViewStore<DateState, DateAction>
  ) {
    self.viewStore = viewStore
    self.monthFormatter = DateFormatter(dateFormat: "MMMM", calendar: viewStore.calendar)
    self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: viewStore.calendar)
  }
  
  var body: some View {
    VStack(spacing: .p8.adaptRatio()) {
      CalendarView(
        calendar: viewStore.calendar,
        date: .constant(viewStore.currentDay),
        content: { date in
          DateElementView(
            viewStore,
            date: date
          )
        },
        trailing: { date in
          UnfocusedDateElementView(viewStore, date)
        },
        header: { date in
          WeekdayElementView(viewStore, date)
        },
        title: { date in
          MonthlyElementView(
            viewStore,
            date
          )
        }
      )
        .equatable()
        .stay(.dark)
    }
    .padding(.p16.adaptRatio())
  }
}

struct DateElementView: View {
  var viewStore: ViewStore<DateState, DateAction>
  let date: Date
  let dayFormatter: DateFormatter
  
  init(
    _ viewStore: ViewStore<DateState, DateAction>,
    date: Date
  ) {
    self.viewStore = viewStore
    self.date = date
    self.dayFormatter = DateFormatter(dateFormat: "d", calendar: viewStore.calendar)
  }
  
  var coloring: (background: Color, title: Color) {
    determineColor(
      timing: .init(date),
      selection: .init(viewStore.currentDay, date: date)
    )
  }
  
  
  var body: some View {
    Button(
      action: {
        withAnimation {
          viewStore.send(.onChange(currentDay: date))
        }
      }
    ) {
      Text("00")
        .padding(.p8.adaptRatio())
        .foregroundColor(.clear)
        .background(coloring.background)
        .cornerRadius(.r8.adaptRatio())
        .accessibilityHidden(true)
        .if(date.isInFuture) {
          $0.overlay(
            Image(systemName: "lock")
              .font(.pHeadline.bold())
              .foregroundColor(coloring.title)
          )
        }.if(!date.isInFuture) {
          $0.overlay(
            Text(dayFormatter.string(from: date))
              .font(.pHeadline.bold())
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

struct UnfocusedDateElementView: View {
  
  let dayFormatter: DateFormatter
  let date: Date
  
  init(_ viewStore: ViewStore<DateState, DateAction>, _ date: Date) {
    self.dayFormatter = DateFormatter(dateFormat: "d", calendar: viewStore.calendar)
    self.date = date
  }
  
  var body: some View {
    if date.isInFuture {
      Image(systemName: "lock")
        .font(.pHeadline.bold())
        .padding(4.adaptRatio())
        .foregroundColor(.mono.offblack)
    } else {
      Text(dayFormatter.string(from: date))
        .font(.pHeadline.bold())
        .padding(4.adaptRatio())
        .foregroundColor(.mono.offblack)
    }
  }
}

struct WeekdayElementView: View {
  
  let weekDayFormatter: DateFormatter
  let date: Date
  
  init(_ viewStore: ViewStore<DateState, DateAction>, _ date: Date) {
    self.date = date
    self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: viewStore.calendar)
  }
  
  var body: some View {
    Text(weekDayFormatter.string(from: date))
      .padding(.p8.adaptRatio())
      .font(.pHeadline.bold())
  }
}

struct MonthlyElementView: View {
  let viewStore: ViewStore<DateState, DateAction>
  let date: Date
  let monthFormatter: DateFormatter
  
  init(
    _ viewStore: ViewStore<DateState, DateAction>,
    _ date: Date
  ) {
    self.date = date
    self.viewStore = viewStore
    self.monthFormatter = DateFormatter(dateFormat: "MMMM", calendar: viewStore.calendar)
  }
  
  var body: some View {
    HStack {
      Text(monthFormatter.string(from: date))
        .font(.pHeadline.bold())
        .padding(.p8.adaptRatio())
      Spacer()
      Button {
        withAnimation {
          guard let newDate = viewStore.calendar.date(
            byAdding: .month,
            value: -1,
            to: viewStore.currentDay
          ) else {
            return
          }
          
          withAnimation {
            viewStore.send(.onChange(currentDay: newDate))
          }
        }
      } label: {
        Label(
          title: { Text("Previous") },
          icon: {
            Image(systemName: "chevron.left")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(
                width: CGFloat(16.0).adaptRatio(),
                height: CGFloat(16.0).adaptRatio()
              )
              .flipsForRightToLeftLayoutDirection(true)
          }
        )
          .labelStyle(IconOnlyLabelStyle())
          .padding(.horizontal, .p16.adaptRatio())
          .frame(maxHeight: .infinity)
      }
      Button {
        withAnimation {
          guard let newDate = viewStore.calendar.date(
            byAdding: .month,
            value: 1,
            to: viewStore.currentDay
          ) else {
            return
          }
          
          withAnimation {
            viewStore.send(.onChange(currentDay: newDate))
          }
        }
      } label: {
        Label(
          title: { Text("Next") },
          icon: {
            Image(systemName: "chevron.right")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(
                width: CGFloat(16.0).adaptRatio(),
                height: CGFloat(16.0).adaptRatio()
              )
              .flipsForRightToLeftLayoutDirection(true)
          }
        )
          .labelStyle(IconOnlyLabelStyle())
          .padding(.horizontal, .p16.adaptRatio())
          .frame(maxHeight: .infinity)
      }
    }
  }
}
