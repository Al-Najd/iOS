//
//  Al_NajdApp.swift
//  Shared
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import SwiftUI
import ComposableArchitecture
import Onboarding
import Settings

enum LifecycleAction {
  case becameActive
  case becameInActive
  case wentToBackground
}

@main
struct Al_NajdApp: App {
  
  @Environment(\.scenePhase) var scenePhase
  
  let store: Store<RootState, RootAction> = .mainRoot
  
  var plugins: [AppPlugin] {
    [
      ThemePlugin(),
      CorePlugin(),
      AppearancesPlugin(),
      ReportPlugin(),
    ]
  }
  
  init() {
    plugins.forEach { $0.setup() }
  }
  
  var body: some Scene {
    WithViewStore(self.store) { viewStore in
      WindowGroup {
        MainTabView(
          store: store
        )
      }.onChange(of: scenePhase) { scenePhase in
        switch scenePhase {
        case .active:
          viewStore.send(.lifecycleAction(.becameActive))
        case .inactive:
          viewStore.send(.lifecycleAction(.becameInActive))
        case .background:
          viewStore.send(.lifecycleAction(.wentToBackground))
        @unknown default:
          break
        }
      }
      
      #if os(macOS)
      Settings {
        SettingsView(
          store: store.scope(
            state: \.settingsState,
            action: RootAction.settingsAction
          )
        )
      }
      #endif
    }
  }
}
