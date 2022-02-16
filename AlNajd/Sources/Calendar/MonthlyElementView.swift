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

public struct MonthlyElementView: View {
  let date: Date
  let monthFormatter: DateFormatter
  let currentDate: Date
  let onChange: ((Date) -> Void)
  let calendar: Calendar
  
    public init(
    _ calendar: Calendar,
    _ date: Date,
    _ currentDate: Date,
    _ onChange: @escaping ((Date) -> Void) = { _ in }
  ) {
    self.calendar = calendar
    self.date = date
    self.currentDate = currentDate
    self.monthFormatter = DateFormatter(dateFormat: "MMMM", calendar: calendar)
    self.onChange = onChange
  }
  
  public var body: some View {
    HStack {
      Text(monthFormatter.string(from: date))
        .scaledFont(.pHeadline, .bold)
        .padding(.p8.adaptRatio())
      Spacer()
      Button {
        withAnimation {
          guard let newDate = calendar.date(
            byAdding: .month,
            value: -1,
            to: currentDate
          ) else {
            return
          }
          
          withAnimation {
            onChange(newDate)
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
          guard let newDate = calendar.date(
            byAdding: .month,
            value: 1,
            to: currentDate
          ) else {
            return
          }
          
          withAnimation {
            onChange(newDate)
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
