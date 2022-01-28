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

public struct UnfocusedDateElementView: View {
  let dayFormatter: DateFormatter
  let date: Date
  
  public init(calendar: Calendar, date: Date) {
    self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
    self.date = date
  }
  
  public var body: some View {
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
