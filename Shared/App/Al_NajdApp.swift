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
import Common

@main
struct Al_NajdApp: App {
  @Environment(\.scenePhase) private var scenePhase
  public let store = Store<RootState, RootAction>(
    initialState: RootState(),
    reducer: rootReducer,
    environment: CoreEnvironment.live(RootEnvironment())
  )
  
  let plugins: [AppPlugin] = [
    ThemePlugin(),
    CorePlugin(),
    AppearancesPlugin(),
    ReportPlugin(),
  ]
  
  var body: some Scene {
    WindowGroup {
      RootView(store: self.store)
        .onAppear {
          plugins.forEach { $0.setup() }
        }
    }
  }
}
