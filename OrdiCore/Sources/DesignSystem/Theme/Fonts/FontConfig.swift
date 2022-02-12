//
//  FontConfig.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 02/06/2021.
//  Copyright © 2021 RamySDK. All rights reserved.
//

import Foundation

// MARK: - ConfigFonts
public struct ConfigFonts: Codable {
  public let fonts: [ConfigFontsElement]
  public let defaultConfigurations: ConfigFontsDefaultConfigurations
  
  enum CodingKeys: String, CodingKey {
    case fonts = "fonts"
    case defaultConfigurations = "default_configurations"
  }
  
  public init(fonts: [ConfigFontsElement], defaultConfigurations: ConfigFontsDefaultConfigurations) {
    self.fonts = fonts
    self.defaultConfigurations = defaultConfigurations
  }
}

// MARK: - ConfigDefaultConfigurations
public struct ConfigFontsDefaultConfigurations: Codable {
  public let type: String
  public let locale: String
  
  enum CodingKeys: String, CodingKey {
    case type = "type"
    case locale = "locale"
  }
  
  public init(type: String, locale: String) {
    self.type = type
    self.locale = locale
  }
  
  public func sdkFriendlyType() -> FontType {
    .init(string: type)
  }
  
  public func sdkFriendlyLocale() -> FontLocale {
    .init(string: locale)
  }
}

// MARK: - ConfigFont
public struct ConfigFontsElement: Codable {
  public let family: String
  public let locale: String
  public let type: String
  
  enum CodingKeys: String, CodingKey {
    case family = "family"
    case locale = "locale"
    case type = "type"
  }
  
  public init(family: String, locale: String, type: String) {
    self.family = family
    self.locale = locale
    self.type = type
  }
  
  public func sdkFriendlyType() -> FontType {
    .init(string: type)
  }
  
  public func sdkFriendlyLocale() -> FontLocale {
    .init(string: locale)
  }
  
  public func toSDKFont() -> FontDetails {
    FontDetails(name: self.family, fontLocale: sdkFriendlyLocale(), fontType: sdkFriendlyType())
  }
}
