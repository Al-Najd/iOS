//
//  ScheduleView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 06/02/2022.
//

import Foundation
import Core
import SwiftUI
import Utils
import Calendar
import DesignSystem
import PreviewableView

public struct ScheduleView: View {
  
  let calendar: Calendar
  @Binding var date: Date
  
  public init(
    calendar: Calendar,
    date: Binding<Date>
  ) {
    self.calendar = calendar
    self._date = date
  }
  
  public var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        HStack {
          Text("7th of")
            .padding([.leading, .vertical])
            .font(.pTitle2)
            .foregroundColor(.mono.body)
          
          
          VStack(alignment: .leading) {
            Text("Feb")
            ProgressView()
              .progressViewStyle(.linear)
          }.padding([.vertical, .trailing])
        }
        .fillOnLeading()
        .background(
          Color.mono.background
        )
        .border(Color.mono.line, width: 1)
        .padding(.horizontal, -1)
        
//        CalendarView(
//          calendar: calendar, date: $date, content: { date in
//            DateElementView(
//              calendar: calendar,
//              date: date,
//              currentDate: date,
//              onChange: {_ in }
//            )
//          }, trailing: { _ in
//            UnfocusedDateElementView(
//              calendar: calendar,
//              date: date
//            ).opacity(0)
//          }, header: { _ in
//            EmptyView()
//          }, title: { _ in
//            EmptyView()
//          }
//        ).padding()
      }
    }.background(
      Color.mono.input.ignoresSafeArea()
    )
  }
}

struct ScheduleView_Previews: PreviewProvider {
  static var previews: some View {
    ScheduleView(calendar: .current, date: .constant(.now))
  }
}
