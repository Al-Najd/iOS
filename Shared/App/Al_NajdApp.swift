//
//  Al_NajdApp.swift
//  Shared
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import SwiftUI
import Home
import ComposableArchitecture
import Common

@main
struct Al_NajdApp: App {
  public let store = Store<RootState, RootAction>(
    initialState: .home(.init()),
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
      RootView(store: .live)
        .onAppear {
          plugins.forEach { $0.setup() }
        }
    }
  }
}
