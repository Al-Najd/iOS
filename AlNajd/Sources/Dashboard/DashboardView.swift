//
//  DashboardView.swift
//  
//
//  Created by Ahmed Ramy on 11/02/2022.
//

import SwiftUI
import DesignSystem
import Utils
import PreviewableView
import ComposableArchitecture

struct DashboardSegment: Identifiable, Hashable {
  let id = UUID().uuidString
  let title: String
}

extension DashboardSegment {
    static let prayers: DashboardSegment = .init(title: "Prayers".localized)
    static let azkar: DashboardSegment = .init(title: "Azkar".localized)
    static let allStats: DashboardSegment = .init(title: "All Stats".localized)
  
  static let allSegments: [DashboardSegment] = [
    prayers,
    azkar,
    allStats
  ]
}

public struct DashboardView: View {
  let store: Store<DashboardState, DashboardAction>
  
  public init(store: Store<DashboardState, DashboardAction>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: .zero) {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(spacing: .p16) {
            ForEach(viewStore.reports) { report in
              RangeAnalysisCardView(progress: report)
            }
          }.padding(.p16)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView(
      store: .mock
    ).background(
        Color.mono.background.ignoresSafeArea()
      )
      .stay(.dark)
  }
}
