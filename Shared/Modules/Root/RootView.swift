//
//  RootView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/03/2022.
//

import SwiftUI
import ComposableArchitecture
import Home
import TCACoordinators
import PrayerDetails

public struct RootView: View {
  public let store: Store<CoordinatorState, CoordinatorAction>

  public var body: some View {
    TCARouter(store) { screen in
      SwitchStore(screen) {
        CaseLet(state: /RootState.home, action: RootAction.home, then: HomeView.init)
        CaseLet(state: /RootState.prayerDetails, action: RootAction.prayerDetails, then: PrayerDetailsView.init)
      }
    }
  }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
      RootView(store: .live)
    }
}

extension Store where State == CoordinatorState, Action == CoordinatorAction {
  static let live: Store<CoordinatorState, CoordinatorAction> = .init(
    initialState: .init(),
    reducer: coordinatorReducer,
    environment: ()
  )
}
