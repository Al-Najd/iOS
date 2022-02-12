//
//  HorizontalWeekSliderView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 28/01/2022.
//

import SwiftUI
import DesignSystem
import Utils

// MARK: - Horizontal Week Slider
public struct HorizontalWeekSliderView: View {
  let activeDate: Date
  let currentWeek: [Date]
  let onChange: (Date) -> Void
  
  init(
    _ activeDay: Date,
    _ currentWeek: [Date],
    _ onChange: @escaping (Date) -> Void
  ) {
    self.activeDate = activeDay
    self.onChange = onChange
    self.currentWeek = currentWeek
  }
  
  public var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      ScrollViewReader { value in
        HStack(spacing: .p32.adaptRatio()) {
          ForEach(currentWeek, id: \.self) { date in
            Button {
              withAnimation {
                onChange(date)
              }
            } label: {
              createDateText(date, activeDate)
            }.id(date.day)
          }
        }
        .frame(minWidth: getScreenSize().width)
        .onAppear(
          perform: {
            withAnimation(.spring()) {
              value.scrollTo(activeDate, anchor: .center)
            }
          }
        )
      }
    }
  }
  
  @ViewBuilder
  func createDateText(
    _ date: Date,
    _ activeDate: Date
  ) -> some View {
    VStack(alignment: .center, spacing: .p8.adaptRatio()) {
      Text("\(date.day)")
        .font(date.day == activeDate.day
              ? .pBody.bold()
              : .pBody)
        .foregroundColor(
          date.day == activeDate.day
          ? .mono.offwhite
          : .mono.placeholder
        )
        .scaleEffect(
          date.day == activeDate.day
          ? 1.0.adaptV(max: 2)
          : 0.75.adaptV(max: 1.5)
        )
      if date.day == activeDate.day {
        Text("\(date.monthName(ofStyle: .threeLetters))")
          .font(
            .pFootnote.bold()
          )
          .foregroundColor(
            date.day == activeDate.day
            ? .mono.offwhite
            : .mono.placeholder
          )
      }
      
      if date.isInFuture {
        Image(systemName: "lock")
          .font(
            .pFootnote.bold()
          )
          .foregroundColor(
            date.day == activeDate.day
            ? .mono.offwhite
            : .mono.placeholder
          )
      }
    }
  }
}
