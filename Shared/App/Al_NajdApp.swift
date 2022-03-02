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
import Root

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: RootState.init(),
    reducer: rootReducer,
    environment: .live
  )
  
  lazy var viewStore = ViewStore(
    self.store.scope(state: { _ in () }),
    removeDuplicates: ==
  )
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    self.viewStore.send(.appDelegate(.didFinishLaunching))
    return true
  }
  
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    self.viewStore.send(.appDelegate(.didRegisterForRemoteNotifications(.success(deviceToken))))
  }
  
  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    self.viewStore.send(
      .appDelegate(.didRegisterForRemoteNotifications(.failure(error as NSError)))
    )
  }
}

@main
struct Al_NajdApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  @Environment(\.scenePhase) private var scenePhase
  @ObservedObject var viewStore: ViewStore<ViewState, RootAction>
  
  struct ViewState: Equatable {
    let isOnboardingPresented: Bool
    
    init(state: RootState) {
      self.isOnboardingPresented = state.onboardingState.didFinishOnboarding
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
        RootView()
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
