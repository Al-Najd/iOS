//
//  HomeCoordinator.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 24/10/2021.
//
import PulseUI
import SwiftUI

final class PrayersState: ObservableObject {
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
    ZStack {
      Color("splash")
        .ignoresSafeArea(.all, edges: .vertical)
      VStack {
        Spacer()
        Image("main_background")
          .resizable()
          .aspectRatio(contentMode: .fit)
      }.ignoresSafeArea(.all, edges: .vertical)
      TabView(selection: $selectedTab) {
        PrayersView()
          .tabItem {
            Text("Prayers".localized)
              .font(.pFootnote)
              .foregroundColor(
                selectedTab == .home ? .secondary1.default : .secondary3.dark
              )
          }
          .tag(Tab.home)
        
        AzkarView()
          .tabItem {
            Text("Azkar".localized)
              .font(.pFootnote)
              .foregroundColor(
                selectedTab == .home ? .secondary1.default : .secondary3.dark
              )
          }
        
        PlansView()
          .tabItem {
            Text("Plans".localized)
              .font(.pFootnote)
              .foregroundColor(
                selectedTab == .home ? .secondary1.default : .secondary3.dark
              )
          }
        
        SettingsView()
          .tabItem {
            Text("Debug Mode")
              .font(.pFootnote)
              .foregroundColor(
                selectedTab == .home ? .secondary1.default : .secondary3.dark
              )
          }
          .tag(Tab.settings)
      }
    }
  }
}

struct MainCoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    MainCoordinatorView()
      .environmentObject(app.state.homeState)
  }
}
