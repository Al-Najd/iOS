//
//  PlaygroundPreviewApp.swift
//  PlaygroundPreview
//
//  Created by Ahmed Ramy on 04/04/2023.
//

import SwiftUI
import DesignSystem

@main
struct PlaygroundPreviewApp: App {
  let plugins: [AppPlugin] = [
    ThemePlugin(),
    CorePlugin(),
    AppearancesPlugin(),
    ReportPlugin(),
  ]

  var body: some Scene {
    WindowGroup {
      PlaygroundView()
        .onAppear {
          plugins.forEach { $0.setup() }
        }
    }
  }
}
