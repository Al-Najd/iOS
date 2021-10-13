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

public struct DefaultTheme: Theme {
  public var primary: BrandColor = PrimaryPalette()
  public var secondary: BrandColor = SecondaryPalette()
  public var monochromatic: MonochromaticColor = MonochromaticPalette()
  public var transparency: Transparency = TransparencyPalette()
  public var success: BrandColor = SuccessPalette()
  public var warning: BrandColor = WarningPalette()
  public var danger: BrandColor = DangerPalette()
  public var info: BrandColor = InfoPalette()
  public var largeShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 72, position: .zero)
  public var mediumShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 32, position: .zero)
  public var smallShadow: ARShadow = ARShadow(color: .black.opacity(0.09), radius: 16, position: .zero)
  
  
  public func setupFont() -> FontManager {
    guard let url = Bundle.main.url(forResource: "fonts", withExtension: "json") else { fatalError() }
    do {
      let data = try Data(contentsOf: url)
      let configs = try JSONDecoder().decode(ConfigFonts.self, from: data)
      return FontManager(
        configuration: FontManager.Configuration(
          fontsLocale: configs.defaultConfigurations.sdkFriendlyLocale(),
          fontsType: configs.defaultConfigurations.sdkFriendlyType(),
          availableFonts: configs.fonts.map { $0.toSDKFont() }
        )
      )
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}
