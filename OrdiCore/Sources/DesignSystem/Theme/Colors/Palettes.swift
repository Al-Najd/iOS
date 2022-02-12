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
  
  public init(_ bundle: Bundle = .main) {
    self.`default` = .init("Primary.default", bundle: bundle)
    self.dark = .init("Primary.dark", bundle: bundle)
    self.darkMode = .init("Primary.darkMode", bundle: bundle)
    self.light = .init("Primary.light", bundle: bundle)
    self.background = .init("Primary.background", bundle: bundle)
  }
}

public struct SecondaryPalette: BrandColor {
  public var `default`: Color
  public var dark: Color
  public var darkMode: Color
  public var light: Color
  public var background: Color
  
  public init(_ bundle: Bundle = .main) {
    self.`default` = .init("Secondary.default", bundle: bundle)
    self.dark = .init("Secondary.dark", bundle: bundle)
    self.darkMode = .init("Secondary.darkMode", bundle: bundle)
    self.light = .init("Secondary.light", bundle: bundle)
    self.background = .init("Secondary.background", bundle: bundle)
  }
}

public struct SuccessPalette: BrandColor {
  public var `default`: Color
  public var dark: Color
  public var darkMode: Color
  public var light: Color
  public var background: Color
  
  public init(_ bundle: Bundle = .main) {
    self.`default` = .init("Success.default", bundle: bundle)
    self.dark = .init("Success.dark", bundle: bundle)
    self.darkMode = .init("Success.darkMode", bundle: bundle)
    self.light = .init("Success.light", bundle: bundle)
    self.background = .init("Success.background", bundle: bundle)
  }
}

public struct WarningPalette: BrandColor {
  public var `default`: Color
  public var dark: Color
  public var darkMode: Color
  public var light: Color
  public var background: Color
  
  public init(_ bundle: Bundle = .main) {
    self.`default` = .init("Warning.default", bundle: bundle)
    self.dark = .init("Warning.dark", bundle: bundle)
    self.darkMode = .init("Warning.darkMode", bundle: bundle)
    self.light = .init("Warning.light", bundle: bundle)
    self.background = .init("Warning.background", bundle: bundle)
  }
}

public struct DangerPalette: BrandColor {
  public var `default`: Color
  public var dark: Color
  public var darkMode: Color
  public var light: Color
  public var background: Color
  
  public init(_ bundle: Bundle = .main) {
    self.`default` = .init("Danger.default", bundle: bundle)
    self.dark = .init("Danger.dark", bundle: bundle)
    self.darkMode = .init("Danger.darkMode", bundle: bundle)
    self.light = .init("Danger.light", bundle: bundle)
    self.background = .init("Danger.background", bundle: bundle)
  }
}

public struct InfoPalette: BrandColor {
  public var `default`: Color
  public var dark: Color
  public var darkMode: Color
  public var light: Color
  public var background: Color
  
  public init(_ bundle: Bundle = .main) {
    self.`default` = .init("Info.default", bundle: bundle)
    self.dark = .init("Info.dark", bundle: bundle)
    self.darkMode = .init("Info.darkMode", bundle: bundle)
    self.light = .init("Info.light", bundle: bundle)
    self.background = .init("Info.background", bundle: bundle)
  }
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
  public var offblack: Color
  public var ash: Color
  public var body: Color
  public var label: Color
  public var placeholder: Color
  public var line: Color
  public var input: Color
  public var background: Color
  public var offwhite: Color
  
  init(_ bundle: Bundle = .main) {
    self.offblack = .init("Monochromatic.offblack", bundle: bundle)
    self.ash = .init("Monochromatic.offblack", bundle: bundle)
    self.body = .init("Monochromatic.body", bundle: bundle)
    self.label = .init("Monochromatic.label", bundle: bundle)
    self.placeholder = .init("Monochromatic.placeholder", bundle: bundle)
    self.line = .init("Monochromatic.line", bundle: bundle)
    self.input = .init("Monochromatic.input", bundle: bundle)
    self.background = .init("Monochromatic.background", bundle: bundle)
    self.offwhite = .init("Monochromatic.offwhite", bundle: bundle)
  }
}

class CurrentBundleFinder {}

extension Foundation.Bundle {
        
    static var designSystemBundle: Bundle = {
        /* The name of your local package, prepended by "LocalPackages_" */
        let bundleName = "OrdiCore_DesignSystem"
        let candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,
            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            /* For command-line tools. */
            Bundle.main.bundleURL,
            /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
}
