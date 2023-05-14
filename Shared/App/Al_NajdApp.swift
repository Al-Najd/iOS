//
//  Al_NajdApp.swift
//  Shared
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import Common
import ComposableArchitecture
import Home
import SwiftUI

@main
struct Al_NajdApp: App {
  let plugins: [AppPlugin] = [
    CorePlugin(),
    ThemePlugin(),
    AppearancesPlugin(),
    ReportPlugin(),
  ]

  init() {
    plugins.forEach { $0.setup() }
  }

  var body: some Scene {
    WindowGroup {
      RootView(store: .mainRoot)
    }
  }
}
