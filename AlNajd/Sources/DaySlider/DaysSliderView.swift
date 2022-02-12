//
//  DaysSliderView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 30/01/2022.
//

import DesignSystem
import SwiftUI
import Utils
import ReusableUI

public struct DaysSliderView: View {
  let currentDate: Date
  let currentWeek: [Date]
  let onChange: (Date) -> Void
  
  public init(currentDate: Date, currentWeek: [Date], onChange: @escaping (Date) -> Void) {
    self.currentDate = currentDate
    self.currentWeek = currentWeek
    self.onChange = onChange
  }
  
  public var body: some View {
    VStack(spacing: .p8.adaptRatio()) {
      HStack(spacing: 0) {
        HorizontalWeekSliderView(
          currentDate,
          currentWeek,
          onChange
        )
      }.frame(maxWidth: .infinity)
        .stay(.light)
        .padding([.horizontal, .bottom], .p16.adaptRatio())
        .padding(.top, .p4.adaptRatio())
        .background(
          Color
            .primary
            .dark
            .cornerRadius(.r16, corners: [.bottomLeft, .bottomRight])
            .ignoresSafeArea()
            .stay(.light)
        )
        .shadow(radius: 4.adaptRatio(), x: 0, y: 4.adaptRatio())
        .background(
          Color
            .primary
            .background
            .ignoresSafeArea()
        )
    }
  }
}

struct DaysSliderView_Previews: PreviewProvider {
  private static var currentWeek: [Date] {
    ((-4)...(-1)).map { Date.now.adding(.day, value: $0) }
    .appending(.now)
    .appending(elements: ((1)...(4)).map { Date.now.adding(.day, value: $0) })
  }
  
  static var previews: some View {
    DaysSliderView(currentDate: .now, currentWeek: currentWeek, onChange: {_ in })
  }
}
