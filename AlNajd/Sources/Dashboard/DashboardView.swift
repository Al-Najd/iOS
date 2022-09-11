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
import Inject
import ReusableUI
import Localization
import Assets

struct DashboardSegment: Identifiable, Hashable {
  let id = UUID().uuidString
  let title: String
}

extension DashboardSegment {
  static let faraaid: DashboardSegment = .init(title: L10n.faraaid)
  static let sunnah: DashboardSegment = .init(title: L10n.sunnah)
  static let nawafil: DashboardSegment = .init(title: L10n.nafila)
  static let azkar: DashboardSegment = .init(title: L10n.nafila)
  
  static let allSegments: [DashboardSegment] = [
    faraaid,
    sunnah,
    nawafil,
    azkar
  ]
}

struct NafilaAnalyticsData {
  let date: Date
  let count: Int
  
  static let dummy: [NafilaAnalyticsData] = {
    (6...0).map {
      .init(
        date: Date.now.startOfDay.adding(.day, value: -$0),
        count: Int.random(in: 0...8)
      )
    }
  }()
}

public struct DashboardView: View {
  let store: Store<DashboardState, DashboardAction>
  @ObserveInjection var inject
  
  public init(store: Store<DashboardState, DashboardAction>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      ScrollView(.vertical) {
        VStack(spacing: .p16) {
        makeCurrentStreakView()
        HStack {
          makeMetricView(title: L10n.faraaid, value: L10n.prayers)
          makeMetricView(title: L10n.azkar, value: L10n.azkarAlSabah)
        }.padding(.horizontal)
        
        makeNafilaChartView()
          .padding(.horizontal)
        }
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
      .enableInjection()
    }
  }
  
  @ViewBuilder
  func makeCurrentStreakView() -> some View {
    VStack {
      Label("Current Streak", systemImage: "flame.fill")
        .scaledFont(.pSubheadline)
        .foregroundColor(Asset.Colors.Primary.bluberry.swiftUIColor)
      Text("32 Day")
        .foregroundColor(Asset.Colors.Primary.solarbeam.swiftUIColor)
        .scaledFont(.pTitle3, .bold)
    }
    .padding()
    .fill()
    .background(
      RoundedRectangle(cornerRadius: .r16)
        .fill()
        .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
        .shadow(radius: .r8)
    )
    .padding(.horizontal)
  }
  
  @ViewBuilder
  func makeMetricView(title: String, icon: String? = nil, value: String) -> some View {
    VStack(spacing: .zero) {
      Label(title, systemImage: icon ?? "")
        .scaledFont(.pSubheadline)
        .foregroundColor(Asset.Colors.Primary.bluberry.swiftUIColor)
      Text(value)
        .scaledFont(.pTitle3, .bold)
        .foregroundColor(.mono.offwhite)
    }
    .padding()
    .fill()
    .background(
      RoundedRectangle(cornerRadius: .r16)
        .fill()
        .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
        .shadow(radius: .r8)
    )
  }
  
  @ViewBuilder
  func makeNafilaChartView() -> some View {
    VStack {
      
    }
    .padding()
    .fill()
    .frame(height: 320)
    .background(
      RoundedRectangle(cornerRadius: .r16)
        .fill()
        .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
        .shadow(radius: .r8)
    )
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView(
      store: .mock
    ).background(
      Color.mono.background.ignoresSafeArea()
    )
  }
}
