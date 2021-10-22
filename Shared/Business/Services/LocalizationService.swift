//
//  LocalizationService.swift
//  The One (iOS)
//
//  Created by Ahmed Ramy on 22/10/2021.
//

import Foundation

class LocalizationService {
  static func getCurrentLocale() -> FontLocale {
    switch Locale.preferredLanguages[0] {
    case "ar": return .arabic
    case "en": return .english
    default: return .arabic
    }
  }
}
