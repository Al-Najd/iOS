//
//  Palettes.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 28/08/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import SwiftUI

public struct PrimaryPalette: BrandColor {
  public var `default`: Color
  public var dark: Color
  public var darkMode: Color
  public var light: Color
  public var background: Color
  
  init(id: Int) {
    self.`default` = .init("Primary\(id).default")
    self.dark = .init("Primary\(id).dark")
    self.darkMode = .init("Primary\(id).darkMode")
    self.light = .init("Primary\(id).light")
    self.background = .init("Primary\(id).background")
  }
}

public struct SecondaryPalette: BrandColor {
  public var `default`: Color
  public var dark: Color
  public var darkMode: Color
  public var light: Color
  public var background: Color
  
  init(id: Int) {
    self.`default` = .init("Secondary\(id).default")
    self.dark  = .init("Secondary\(id).dark")
    self.darkMode = .init("Secondary\(id).darkMode")
    self.light = .init("Secondary\(id).light")
    self.background = .init("Secondary\(id).background")
  }
}

public struct SuccessPalette: BrandColor {
  public var `default`: Color = .init("Success.default")
  public var dark: Color  = .init("Success.dark")
  public var darkMode: Color = .init("Success.darkMode")
  public var light: Color = .init("Success.light")
  public var background: Color = .init("Success.background")
}

public struct WarningPalette: BrandColor {
  public var `default`: Color = .init("Warning.default")
  public var dark: Color  = .init("Warning.dark")
  public var darkMode: Color = .init("Warning.darkMode")
  public var light: Color = .init("Warning.light")
  public var background: Color = .init("Warning.background")
}

public struct DangerPalette: BrandColor {
  public var `default`: Color = .init("Danger.default")
  public var dark: Color  = .init("Danger.dark")
  public var darkMode: Color = .init("Danger.darkMode")
  public var light: Color = .init("Danger.light")
  public var background: Color = .init("Danger.background")
}

public struct InfoPalette: BrandColor {
  public var `default`: Color = .init("Info.default")
  public var dark: Color  = .init("Info.dark")
  public var darkMode: Color = .init("Info.darkMode")
  public var light: Color = .init("Info.light")
  public var background: Color = .init("Info.background")
}

public struct TransparencyPalette: Transparency {
  public var light: Color = .init("Transparency.light.full")
  public var dark: Color = .init("Transparency.dark.full")
  
  public func light(by percentage: CGFloat) -> Color {
    light
      .opacity(Double(percentage)/100)
  }
  
  public func dark(by percentage: CGFloat) -> Color {
    dark
      .opacity(Double(percentage)/100)
  }
}

public struct MonochromaticPalette: MonochromaticColor {
  public var offblack: Color = .init("Monochromatic.offblack")
  public var ash: Color = .init("Monochromatic.offblack")
  public var body: Color = .init("Monochromatic.body")
  public var label: Color = .init("Monochromatic.label")
  public var placeholder: Color = .init("Monochromatic.placeholder")
  public var line: Color = .init("Monochromatic.line")
  public var input: Color = .init("Monochromatic.input")
  public var background: Color = .init("Monochromatic.background")
  public var offwhite: Color = .init("Monochromatic.offwhite")
}
