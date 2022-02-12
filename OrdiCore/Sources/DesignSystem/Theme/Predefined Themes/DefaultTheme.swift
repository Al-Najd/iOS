//
//  DefaultTheme.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 28/08/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import Foundation
import FontBlaster

public struct DefaultTheme: Theme {
  public var primary: BrandColor = PrimaryPalette()
  public var secondary: BrandColor = SecondaryPalette()
  public var monochromatic: MonochromaticColor = MonochromaticPalette()
  public var transparency: Transparency = TransparencyPalette()
  public var success: BrandColor = SuccessPalette()
  public var danger: BrandColor = DangerPalette()
  public var warning: BrandColor = WarningPalette()
  public var largeShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 72, position: .zero)
  public var mediumShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 32, position: .zero)
  public var smallShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 16, position: .zero)
}

public struct PackageDefaultTheme: Theme {
  public var primary: BrandColor = PrimaryPalette(.designSystemBundle)
  public var secondary: BrandColor = SecondaryPalette(.designSystemBundle)
  public var monochromatic: MonochromaticColor = MonochromaticPalette(.designSystemBundle)
  public var transparency: Transparency = TransparencyPalette()
  public var success: BrandColor = SuccessPalette(.designSystemBundle)
  public var danger: BrandColor = DangerPalette(.designSystemBundle)
  public var warning: BrandColor = WarningPalette(.designSystemBundle)
  public var largeShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 72, position: .zero)
  public var mediumShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 32, position: .zero)
  public var smallShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 16, position: .zero)
}
