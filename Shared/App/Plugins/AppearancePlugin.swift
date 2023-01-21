//
//  AppearancePlugin.swift
//  AppearancePlugin
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import UIKit.UIApplication
import SwiftUI
import DesignSystem

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
      [
				.font: ARFont.pSubheadline.font,
				.foregroundColor: UIColor(Color.mono.offwhite)
			],
      for: .normal
    )

		UISegmentedControl.appearance().setTitleTextAttributes(
			[
				.font: ARFont.pSubheadline.font,
				.foregroundColor: UIColor(Color.mono.offblack)
			],
			for: .selected
		)
  }
  
  func adaptUITableViewAppearance() {
    UITableView.appearance().separatorStyle = .none
    UITableViewCell.appearance().backgroundColor = .clear
    UITableView.appearance().backgroundColor = .clear
    UITableView.appearance(for: .init(userInterfaceStyle: .light)).backgroundColor = .clear
    UITableView.appearance(for: .init(userInterfaceStyle: .dark)).backgroundColor = .clear
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
