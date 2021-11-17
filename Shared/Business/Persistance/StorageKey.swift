//
//  CachingKey.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public enum StorageKey: CaseIterable {
  case user
  case encryptedUser
  case launchCount
  case defaultWallet
  case wallets
  case roi
  case userToken
  case preferredVerificationMethod
  case requestsFromYou
  case requestsFromOthers
  
  /// This key is not used for any caching
  case postRequestsKey
  
  var key: String {
    switch self {
    case .user:
      return "user"
    case .encryptedUser:
      return "encUser"
    case .launchCount:
      return "launchCount"
    case .wallets:
      return "wallets"
    case .defaultWallet:
      return "defaultWallet"
    case .roi:
      return "roi"
    case .userToken:
      return "userToken"
    case .preferredVerificationMethod:
      return "preferredVerificationMethod"
    case .requestsFromYou:
      return "case requestsFromYou"
    case .requestsFromOthers:
      return "case requestsFromOthers"
    case .postRequestsKey:
      return "postRequestsKey"
    }
  }
  
  var suitableStorage: CacheManager.SupportedStorage {
    switch self {
    case .defaultWallet:
      return .encrypted
    case .encryptedUser:
      return .encrypted
    case .roi:
      return .encrypted
    case .userToken:
      return .encrypted
    case .user:
      return .userDefaults
    case .launchCount:
      return .userDefaults
    case .wallets:
      return .encrypted
    case .preferredVerificationMethod:
      return .userDefaults
    case .requestsFromYou:
      return .userDefaults
    case .requestsFromOthers:
      return .userDefaults
    case .postRequestsKey:
      return .userDefaults
    }
  }
}
