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
    adaptTabBarAppearance()
    adaptNavigationBarAppearance()
    adaptUITableViewAppearance()
    UISegmentedControl.appearance().setTitleTextAttributes(
      [.font: ARFont.subheadline.font],
      for: .normal
    )
  }
  
  func adaptUITableViewAppearance() {
    UITableView.appearance(for: .init(userInterfaceStyle: .light)).backgroundColor = UIColor(.mono.background)
    UITableView.appearance(for: .init(userInterfaceStyle: .dark)).backgroundColor = UIColor(.mono.offwhite)
  }
  
  func adaptTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
    appearance.backgroundColor = UIColor(.mono.background)
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
    
    UITabBarItem.appearance().setTitleTextAttributes(
      [.font : ARFont.textXSmall.font],
      for: []
    )
  }
  
  func adaptNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
    appearance.backgroundColor = UIColor(.mono.background)
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
}
