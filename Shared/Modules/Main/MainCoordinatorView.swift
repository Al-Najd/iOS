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

struct MainCoordinatorView: View {
  @EnvironmentObject var state: AppState
  @State var selectedTab: Tab = .home
  var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
      Color("splash")
        .ignoresSafeArea(.all, edges: .vertical)
      VStack {
        Spacer()
        Image("main_background")
          .resizable()
          .aspectRatio(contentMode: .fit)
      }.ignoresSafeArea(.all, edges: .vertical)
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
      .tabViewStyle(.page(indexDisplayMode: .never))
      
      TabBarView(selectedTab: $selectedTab)
        
    }
    .ignoresSafeArea(.all, edges: .vertical)
  }
}

struct MainCoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    MainCoordinatorView()
      .environmentObject(app.state.homeState)
  }
}
