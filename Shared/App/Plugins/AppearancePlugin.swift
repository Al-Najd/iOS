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
    UITableView.appearance().backgroundColor = .clear
    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.secondary3.default)
  }
}
