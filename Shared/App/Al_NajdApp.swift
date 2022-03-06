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
import Utils

enum LifecycleAction {
  case becameActive
  case becameInActive
  case wentToBackground
}

@main
struct Al_NajdApp: App {
  
  @Environment(\.scenePhase) var scenePhase
  @ObservedObject var viewStore: ViewStore<ViewState, RootAction>
  let store: Store<RootState, RootAction> = .mainRoot
  
  struct ViewState: Equatable {
    let isOnboardingPresented: Bool
    
    init(state: RootState) {
      self.isOnboardingPresented = state.onboardingState?.didFinishOnboarding ?? false
    }
  }
  
  lazy var plugins: [AppPlugin] = {
    [
      ThemePlugin(),
      CorePlugin(),
      AppearancesPlugin(),
      ReportPlugin(),
    ].with { $0.forEach { $0.setup() } }
  }()
  
  init() {
    self.viewStore = ViewStore(self.store.scope(state: ViewState.init))
  }
  
  var body: some Scene {
    WithViewStore(self.store) { viewStore in
      WindowGroup {
        if !(viewStore.onboardingState?.didFinishOnboarding ?? true) {
          SplashView {
            MainTabView(store: store)
          }
        } else {
        IfLetStore(
          self.store.scope(state: \.onboardingState, action: RootAction.onboardingAction),
          then: { scopedStore in
            OnboardingView(store: scopedStore) {
                SplashView {
                  MainTabView(store: store)
                }
              }
          }
        )
          .zIndex(2)
        }
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
