//
//  FontManager.swift
//  
//
//  Created by Ahmed Ramy on 06/02/2022.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

import SwiftUI
import FontBlaster
import Utils
import OrdiLogging

public final class FontManager {
  static public var shared: FontManager = .init()
  
  public var supportsAccessibilityAdaption: Bool = false
  public var supportsDeviceSizeAdaption: Bool = true
  public var fontMultiplier: CGFloat = 1.0
  
  // Note: Forced here as the app shouldn't run unless this is set
  private var configuration: Configuration!
  
  public init() {
    fillUpInfoPListWithCustomFont()
    parseFontJSON()
  }
  
  public func getSuitableFont(
    category: FontCategory,
    scale: FontScale,
    weight: FontWeight
  ) -> ARFont {
    guard let suitableFont = configuration.availableFonts
            .first(
              where: {
                $0.fontLocale == configuration.fontsLocale &&
                $0.fontLocale == configuration.fontsLocale &&
                $0.fontType == configuration.fontsType
              }
            )
    else { fatalError("Can't find a suitable font to set") }
    
    return ARFont(fontDetails: suitableFont, fontCategory: category, fontScale: scale, fontWeight: weight)
  }
  
  public func getFont(
    locale: FontLocale,
    type: FontType,
    category: FontCategory,
    scale: FontScale,
    weight: FontWeight
  ) -> ARFont {
    guard let suitableFont = configuration.availableFonts
            .first(where: { $0.fontLocale == locale && $0.fontType == type })
    else { return getSuitableFont(category: category, scale: scale, weight: weight) }
    
    return ARFont(fontDetails: suitableFont, fontCategory: category, fontScale: scale, fontWeight: weight)
  }
}

public extension FontManager {
  struct Configuration: Codable {
    var fontsLocale: FontLocale = .english
    var fontsType: FontType = .sansSerif
    var availableFonts: [FontDetails] = []
  }
}

private extension FontManager {
  func fillUpInfoPListWithCustomFont() {
    Once().run {
      FontBlaster.blast(bundle: .designSystemBundle)
    }
  }
  
  func parseFontJSON() {
    guard let url = Bundle.designSystemBundle.url(forResource: "fonts", withExtension: "json")
    else {
      LoggersManager.error(message: "Couldn't find fonts.json in designSystemBundle")
      fatalError(
        "\(Bundle.allBundles)\n\(Bundle.allBundles.first(where: { $0.url(forResource: "fonts", withExtension: "json") != nil }) ?? Bundle.designSystemBundle)"
      )
    }
    
    do {
      let data = try Data(contentsOf: url)
      let configs = try JSONDecoder().decode(ConfigFonts.self, from: data)
      
      self.configuration =  .init(
        fontsLocale: .init(
          language: .init(
            Bundle.main.preferredLocalizations.first ?? "ar"
          )
        ),
        fontsType: configs.defaultConfigurations.sdkFriendlyType(),
        availableFonts: configs.fonts.map { $0.toSDKFont() }
      )
    } catch {
      LoggersManager.error(
        message: "Couldn't parse fonts.json\nerror: \(error),\ndescription: \(error.localizedDescription)"
      )
      fatalError(
        "\(error.localizedDescription)\n\(Bundle.allBundles)\n\(Bundle.allBundles.first(where: { $0.url(forResource: "fonts", withExtension: "json") != nil }) ?? Bundle.designSystemBundle)"
      )
    }
  }
}
