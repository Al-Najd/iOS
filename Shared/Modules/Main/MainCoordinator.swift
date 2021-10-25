//
//  HomeCoordinator.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 24/10/2021.
//

import SwiftUI

final class HomeState: ObservableObject {
  @Published var sunnah: [Deed] = .sunnah
  @Published var faraaid: [Deed] = .faraaid
  @Published var nafila: [Deed] = .nafila
  
  @Published var accumlatedRewards: [Deed] = []
  @Published var showBuffs: Bool = false
}

struct MainCoordinator: View {
  @EnvironmentObject var state: AppState
  @State var selectedTab: Tab = .home
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeView()
        .tabItem {
          VStack {
            Text("Home")
              .font(.pFootnote)
              .foregroundColor(
                selectedTab == .home ? .secondary1.default : .secondary3.dark
              )
            Image("icn_tabBar_home")
          }
        }
        .tag(Tab.home)
      
      SettingsView()
        .tabItem {
          VStack {
            Text("Debug Mode")
              .font(.pFootnote)
              .foregroundColor(
                selectedTab == .home ? .secondary1.default : .secondary3.dark
              )
            Image("icn_tabBar_settings")
          }
        }
        .tag(Tab.settings)
    }
  }
}

extension MainCoordinator {
  enum Tab {
    case home
    case settings
  }
}
