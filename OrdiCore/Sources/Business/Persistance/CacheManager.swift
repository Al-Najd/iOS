//
//  CacheManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
import Entity

public final class CacheManager {
  public enum SupportedStorage {
    case userDefaults
    case encrypted
    case disk
  }
  
  private let decoder: JSONDecoder
  private let encoder: JSONEncoder
  private lazy var encryptedStorage = EncryptedStorage()
  private lazy var diskStorage = DiskStorage()
  private lazy var userDefaultsStorage = UserDefaultsStorage()
  
  public init(
    decoder: JSONDecoder = .init(),
    encoder: JSONEncoder = .init()
  ) {
    self.decoder = decoder
    self.encoder = encoder
  }
  
  public func fetch<T: Codable>(_ type: T.Type, for key: StorageKey) -> T? {
    return getSuitableStorage(from: key.suitableStorage).fetchValue(for: key)
  }
  
  public func save<T: Codable>(_ value: T, for key: StorageKey) {
    try? getSuitableStorage(from: key.suitableStorage).save(value: value, for: key)
  }
  
  public func remove<T: Codable>(type: T.Type, for key: StorageKey) {
    try? getSuitableStorage(from: key.suitableStorage).remove(type: type, for: key)
  }
}

public extension CacheManager {
  func getSuitableStorage(from choice: SupportedStorage) -> Storage {
    switch choice {
    case .encrypted:
      return encryptedStorage
    case .disk:
      return diskStorage
    case .userDefaults:
      return userDefaultsStorage
    }
  }
}
