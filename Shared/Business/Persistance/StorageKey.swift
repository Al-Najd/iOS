//
//  CachingKey.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public enum StorageKey {
  case daily(String)
  
  var key: String {
    switch self {
    case let .daily(report):
      return "daily-\(report)"
    }
  }
  
  var suitableStorage: CacheManager.SupportedStorage {
    switch self {
    case .daily:
      return .userDefaults
    }
  }
}
