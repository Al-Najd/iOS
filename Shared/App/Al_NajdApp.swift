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
  let plugins: [AppPlugin] = [
    ThemePlugin(),
    CorePlugin(),
    AppearancesPlugin(),
    ReportPlugin(),
  ]
  
  var body: some Scene {
    WindowGroup {
      RootView(store: .mainRoot)
        .onAppear {
          plugins.forEach { $0.setup() }
        }
    }
  }
}
