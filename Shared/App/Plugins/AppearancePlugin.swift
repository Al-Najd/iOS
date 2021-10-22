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
    UITabBar.appearance().isHidden = true
    UITableView.appearance().backgroundColor = .clear
    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.mono.offwhite)
    UISegmentedControl.appearance().backgroundColor = UIColor(.mono.input)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.mono.offblack)], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.mono.offblack)], for: .normal)
    
    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.secondary3.default)
  }
}
