//
//  AppearancePlugin.swift
//  AppearancePlugin
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import UIKit.UIApplication
import SwiftUI

struct AppearancesPlugin: AppPlugin {
  func setup() {
    addAppearances()
  }
}

private extension AppearancesPlugin {
  func addAppearances() {
    UITabBarItem.appearance().setTitleTextAttributes(
      [.font : ARFont.textXSmall.font],
      for: []
    )
    UITableView.appearance().backgroundColor = UIColor(.mono.background)
    UISegmentedControl.appearance().setTitleTextAttributes(
      [.font: ARFont.subheadline.font],
      for: .normal
    )
  }
}
