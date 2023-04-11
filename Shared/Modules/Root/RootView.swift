//
//  RootView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/03/2022.
//

import Assets
import ComposableArchitecture
import Dashboard
import DesignSystem
import Home
import Localization
import PrayerDetails
import SwiftUI
import Azkar

// MARK: - RootView

public struct RootView: View {
    public let store: StoreOf<Root>

    public var body: some View {
        WithViewStore(store) { viewStore in
          SplashView {
            TabView {
              HomeView(store: store.scope(state: \.home, action: Root.Action.home))
                .tabItem {
                  VStack {
                    Image(systemName: "sun.dust.circle.fill")
                    Text(L10n.today)
                  }
                  .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
                }

              DashboardView(store: store.scope(state: \.dashboard, action: Root.Action.dashboard))
                .tabItem {
                  VStack {
                    Image(systemName: "chart.bar.xaxis")
                    Text(L10n.dashboard)
                  }
                  .foregroundColor(Asset.Colors.Primary.blackberry.swiftUIColor)
                }
            }.onAppear {
              // correct the transparency bug for Tab bars
              let tabBarAppearance = UITabBarAppearance()
              tabBarAppearance.configureWithOpaqueBackground()
              UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
              // correct the transparency bug for Navigation bars
              let navigationBarAppearance = UINavigationBarAppearance()
              navigationBarAppearance.configureWithOpaqueBackground()
              UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            }
          }
        }
    }
}
