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
    case let str where str.contains("ar"): return .arabic
    case let str where str.contains("en"): return .english
    default: return .arabic
    }
  }
  
  static func isRTL() -> Bool {
    getCurrentLocale() == .arabic
  }
}
