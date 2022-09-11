//
//  RootView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/03/2022.
//

import SwiftUI
import ComposableArchitecture
import Home
import PrayerDetails
import Localization
import DesignSystem
import Assets
import Dashboard

public struct RootView: View {
  public let store: Store<RootState, RootAction>

  public var body: some View {
    WithViewStore(store) { viewStore in
      DashboardView(store: store.scope(state: { $0.dashboard }, action: RootAction.dashboard))
    }
  }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
      RootView(store: .mainRoot)
    }
}
