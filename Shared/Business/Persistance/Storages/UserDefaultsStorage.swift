//
//  UserDefaultsStorage.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Foundation

final class UserDefaultsStorage {
  let defaults: UserDefaults = UserDefaults(suiteName: "com.belbaqy.belbaqy") ?? .standard
}

extension UserDefaultsStorage: WritableStorage {
  func save<T>(value: T, for key: StorageKey) throws where T : Cachable {
    defaults.set(value.encode(), forKey: key.key)
  }
  
  func remove<T>(type: T.Type, for key: StorageKey) throws where T : Cachable {
    defaults.removeObject(forKey: key.key)
  }
}

extension UserDefaultsStorage: ReadableStorage {
  func fetchValue<T>(for key: StorageKey) throws -> T where T : Cachable {
    guard let value = defaults.data(forKey: key.key)?.decode(T.self) else { throw StorageError.notFound }
    return value
  }
}
