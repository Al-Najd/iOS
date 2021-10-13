//
//  Language.swift
//  Proba B.V.
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Proba B.V. All rights reserved.
//

import Foundation

public enum Language: CaseIterable {
  case arabic
  case english
  
  public var languageCode: String {
    switch self {
    case .arabic: return "ar"
    case .english: return "en"
    }
  }
  
  public init(_ language: String) {
    switch language {
    case "ar": self = .arabic
    case "en": self = .english
    default: self = .english
    }
  }
  
  public init(localeLanguageCode: String) {
    switch localeLanguageCode {
    case "ar": self = .arabic
    case "en": self = .english
    default: self = .english
    }
  }
  
  public var isRTLLanguage: Bool {
    return self == .arabic
  }
}
