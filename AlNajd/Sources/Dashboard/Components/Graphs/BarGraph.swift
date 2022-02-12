//
//  SwiftUIView.swift
//  
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import SwiftUI

public struct BarGraph: View {
  let reports: [DayProgress]
  @State var isPressing: Bool = false
  @State var currentReportID: String = ""
  @State var offset: CGFloat = 0
  
  
  public var body: some View {
    HStack(spacing: .p8) {
      ForEach(reports) { report in
        buildGraphBars(report: report)
      }
    }
    .animation(.easeInOut, value: isPressing)
  }
  
  @ViewBuilder
  func buildGraphBars(report: DayProgress) -> some View {
    VStack(spacing: .p24) {
      GeometryReader { proxy in
        ZStack {
          RoundedRectangle(cornerRadius: .r8)
            .stroke(report.indicator.color.default)
            .frame(maxHeight: .infinity, alignment: .bottom)
          
            RoundedRectangle(cornerRadius: .r8)
              .fill(report.indicator.color.default)
              .opacity(isPressing ? (currentReportID == report.id ? 1 : 0.35) : 1)
              .frame(height: (Double(report.count) / Double(report.limit)) * (proxy.size.height))
              .frame(maxHeight: .infinity, alignment: .bottom)
        }
      }
      .frame(height: 150)
      Text(report.day)
        .font(.pFootnote)
        .foregroundColor(
          isPressing && currentReportID == report.id
          ? report.indicator.color.default
          : .mono.label
        )
    }
    .onTapGesture { }
    .onLongPressGesture(
      minimumDuration: .infinity
    ) { isPressing in
      self.isPressing = isPressing
      currentReportID = isPressing ? report.id : ""
    } perform: {
      isPressing = false
      currentReportID = ""
    }
  }
}
struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView(store: .mock)
      .stay(.dark)
  }
}
