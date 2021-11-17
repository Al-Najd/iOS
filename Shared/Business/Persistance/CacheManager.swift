//
//  CacheManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public final class CacheManager {
  enum SupportedStorage {
    case userDefaults
    case encrypted
    case disk
  }
  
  private let decoder: JSONDecoder
  private let encoder: JSONEncoder
  private lazy var encryptedStorage = EncryptedStorage()
  private lazy var diskStorage = DiskStorage()
  private lazy var userDefaultsStorage = UserDefaultsStorage()
  
  init(
    decoder: JSONDecoder = .init(),
    encoder: JSONEncoder = .init()
  ) {
    self.decoder = decoder
    self.encoder = encoder
  }
  
  func fetch<T: Cachable>(_ type: T.Type, for key: StorageKey) throws -> T {
    return try getSuitableStorage(from: key.suitableStorage).fetchValue(for: key)
  }
  
  func save<T: Cachable>(_ value: T, for key: StorageKey) throws {
    try getSuitableStorage(from: key.suitableStorage).save(value: value, for: key)
  }
  
  func remove<T: Cachable>(type: T.Type, for key: StorageKey) throws {
    try getSuitableStorage(from: key.suitableStorage).remove(type: type, for: key)
  }
}

private extension CacheManager {
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
