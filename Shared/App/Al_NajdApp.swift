//
//  Al_NajdApp.swift
//  Shared
//
//  Created by Ahmed Ramy on 20/01/2022.
//

import SwiftUI

@main
struct Al_NajdApp: App {
    
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
      WindowGroup {
        SplashView {
          MainTabView(
            store: .mainRoot
          )
        }
      }
    }
  }
