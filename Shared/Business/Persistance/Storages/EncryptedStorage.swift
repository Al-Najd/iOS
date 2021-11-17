//
//  EncryptedStorage.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Foundation
import KeychainSwift

public final class EncryptedStorage {
  private let keychain = KeychainSwift()
}

extension EncryptedStorage: WritableStorage {
  public func remove<T>(type: T.Type, for key: StorageKey) throws where T : Cachable {
    keychain.delete(key.key)
  }
  
  public func save<T: Cachable>(value: T, for key: StorageKey) throws {
    keychain.set(value.encode(), forKey: key.key)
  }
}

extension EncryptedStorage: ReadableStorage {
  public func fetchValue<T: Cachable>(for key: StorageKey) throws -> T {
    guard let value = (keychain.getData(key.key) ?? Data()).decode(T.self) else {
      throw StorageError.notFound
    }
    
    return value
  }
}
