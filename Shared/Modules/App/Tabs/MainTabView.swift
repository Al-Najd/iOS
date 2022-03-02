//
//  MainTabView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 22/01/2022.
//

import SwiftUI
import DesignSystem
import Utils
import ReusableUI
import PreviewableView
import ComposableArchitecture
import Schedule
import Dashboard
import Settings
import Prayers
import Azkar
import Rewards

struct MainTabView: View {
  let store: Store<RootState, RootAction>
  @State var tab: Tab = .prayer
  
  init(store: Store<RootState, RootAction>) {
    self.store = store
    UITabBar.appearance().isHidden = true
  }
  
  var body: some View {
    WithViewStore(store.stateless) { viewStore in
      VStack(spacing: 0) {
        ONavigationBar(
          store: store.scope(
            state: \.dateState,
            action: RootAction.dateAction
          )
        )
          .zIndex(1)
        
        TabView(
          selection: $tab
        ) {
          PrayersView(
            store: store.scope(
              state: \.prayerState,
              action: RootAction.prayerAction
            )
          )
            .tag(Tab.prayer)
            .background(content: {
              Color
                .primary
                .background.ignoresSafeArea()
            })
          
          
          
          AzkarView(
            store: store.scope(
              state: \.azkarState,
              action: RootAction.azkarAction
            )
          )
            .tag(Tab.azkar)
            .background(content: {
              Color
                .primary
                .background.ignoresSafeArea()
            })
          
          DashboardView(
            store: store.scope(
              state: \.dashboardState,
              action: RootAction.dashboardAction
            )
          )
            .tag(Tab.dashboard)
            .background(content: {
              Color
                .primary
                .background.ignoresSafeArea()
            })
          
          RewardsView(
            store: store.scope(
              state: \.rewardState,
              action: RootAction.rewardAction
            )
          )
            .tag(Tab.rewards)
            .background(content: {
              Color
                .primary
                .background.ignoresSafeArea()
            })
          
          SettingsView(
            store: store.scope(
              state: \.settingsState,
              action: RootAction.settingsAction
            )
          )
            .tag(Tab.settings)
            .background(content: {
              Color
                .primary
                .background.ignoresSafeArea()
            })
        }
        
        OTabBarView(tab: $tab)
      }
    }
  }
}

struct MainTabView_Previews: PreviewProvider {
  static var previews: some View {
    PreviewableView([.darkMode]) {
      MainTabView(
        store: .mainRoot
      )
    }
  }
}

enum Tab: Int, Identifiable, CaseIterable {
  case dashboard = 3
  case prayer = 1
  case azkar = 2
  case rewards = 4
  case settings = 5
  
  var id: String { "\(self)" }
  
  var title: String {
    switch self {
    case .dashboard:
      return "Dashboard".localized
    case .prayer:
      return "Prayers".localized
    case .azkar:
      return "Azkar".localized
    case .rewards:
      return "Rewards".localized
    case .settings:
      return "Settings".localized
    }
  }
  
  var icon: String {
    switch self {
    case .dashboard:
      return "chart.xyaxis.line"
    case .prayer:
      return "bolt.heart"
    case .azkar:
      return "moon"
    case .rewards:
      return "gift"
    case .settings:
      return "gearshape"
    }
  }
  
  var activeIcon: String {
    switch self {
    case .dashboard:
      return "chart.line.uptrend.xyaxis"
    case .prayer:
      return "bolt.heart.fill"
    case .azkar:
      return "moon.stars.fill"
    case .rewards:
      return "gift.fill"
    case .settings:
      return "gearshape.fill"
    }
  }
}
