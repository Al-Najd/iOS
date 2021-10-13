//
//  ThemePlugin.swift
//  The One
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import UIKit.UIApplication

public struct ThemePlugin: AppPlugin {
  public func setup() {
    setupTheme()
  }
}

private extension ThemePlugin {
  private func setupTheme() {
    ThemeManager.shared.setup()
  }
}
