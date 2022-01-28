//
//  CalendarView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import Entities
import Calendar

struct OCalendarView: View {
  var store: Store<DateState, DateAction>
  
  init(
    _ store: Store<DateState, DateAction>
  ) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: .p8.adaptRatio()) {
        CalendarView(
          calendar: viewStore.calendar,
          date: .constant(viewStore.currentDay),
          content: { date in
            DateElementView(calendar: viewStore.calendar, date: date, currentDate: viewStore.currentDay)
          },
          trailing: { date in
            UnfocusedDateElementView(calendar: viewStore.calendar, date: date)
          },
          header: { date in
            WeekdayElementView(calendar: viewStore.calendar, date)
          },
          title: { date in
            MonthlyElementView(viewStore.calendar, date, viewStore.currentDay)
          }
        )
          .equatable()
          .stay(.dark)
      }.padding(.p16.adaptRatio())
    }
  }
}
