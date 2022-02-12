//
//  File.swift
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

public final class FontManager {
  static public var shared: FontManager = .init()
  public var configuration: Configuration
  
  public init() {
    FontBlaster.blast(bundle: .designSystemBundle)
      guard let url = Bundle.designSystemBundle.url(forResource: "fonts", withExtension: "json")
    else {
        fatalError(
            "zzzz\(Bundle.allBundles)\n\(Bundle.allBundles.first(where: { $0.url(forResource: "fonts", withExtension: "json") != nil }) ?? Bundle.designSystemBundle)"
        ) }
    
    do {
      let data = try Data(contentsOf: url)
      let configs = try JSONDecoder().decode(ConfigFonts.self, from: data)
      
      self.configuration =  .init(
        fontsLocale: .init(
          language: .init(
            Bundle.main.preferredLocalizations.first ?? "en"
          )
        ),
        fontsType: configs.defaultConfigurations.sdkFriendlyType(),
        availableFonts: configs.fonts.map { $0.toSDKFont() }
      )
    } catch {
      fatalError(
        "zzzz\(error.localizedDescription)\n\(Bundle.allBundles)\n\(Bundle.allBundles.first(where: { $0.url(forResource: "fonts", withExtension: "json") != nil }) ?? Bundle.designSystemBundle)"
      )
    }
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
