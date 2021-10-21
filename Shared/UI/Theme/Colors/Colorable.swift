//
//  Colorable.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 28/08/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import SwiftUI

public protocol Colorable {
  var primary1: BrandColor { get }
  var primary2: BrandColor { get }
  var secondary1: BrandColor { get }
  var secondary2: BrandColor { get }
  var secondary3: BrandColor { get }
  var transparency: Transparency { get }
  var success: BrandColor { get }
  var danger: BrandColor { get }
  var monochromatic: MonochromaticColor { get }
}

public protocol BrandColor {
  var `default`: Color { get }
  var dark: Color { get }
  var darkMode: Color { get }
  var light: Color { get }
  var background: Color { get }
}

public protocol MonochromaticColor {
  var offblack: Color { get }
  var ash: Color { get }
  var body: Color { get }
  var label: Color { get }
  var placeholder: Color { get }
  var line: Color { get }
  var input: Color { get }
  var background: Color { get }
  var offwhite: Color { get }
}

public protocol Transparency {
  var light: Color { get }
  var dark: Color { get }
  
  func light(by percentage: CGFloat) -> Color
  func dark(by percentage: CGFloat) -> Color
}

public extension Color {
  static var primary1: BrandColor { ThemeManager.shared.selectedTheme.primary1 }
  static var primary2: BrandColor { ThemeManager.shared.selectedTheme.primary2 }
  static var secondary1: BrandColor { ThemeManager.shared.selectedTheme.secondary1 }
  static var secondary2: BrandColor { ThemeManager.shared.selectedTheme.secondary2 }
  static var secondary3: BrandColor { ThemeManager.shared.selectedTheme.secondary3 }
  static var mono: MonochromaticColor { ThemeManager.shared.selectedTheme.monochromatic }
  static var transparency: Transparency { ThemeManager.shared.selectedTheme.transparency }
  static var success: BrandColor { ThemeManager.shared.selectedTheme.success }
  static var danger: BrandColor { ThemeManager.shared.selectedTheme.danger }
}
