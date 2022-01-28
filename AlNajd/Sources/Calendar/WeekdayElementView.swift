//
//  WeekdayElementView.swift
//  
//
//  Created by Ahmed Ramy on 28/01/2022.
//

import SwiftUI
import Utils
import DesignSystem

public struct WeekdayElementView: View {
  
  let weekDayFormatter: DateFormatter
  let date: Date
  
  public init(calendar: Calendar, _ date: Date) {
    self.date = date
    self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
  }
  
  public var body: some View {
    Text(weekDayFormatter.string(from: date))
      .padding(.p8.adaptRatio())
      .font(.pHeadline.bold())
  }
}
