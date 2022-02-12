//
//  EncryptedStorage.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Foundation
import Entity
import KeychainSwift

public final class EncryptedStorage {
  private let keychain = KeychainSwift()
}

extension EncryptedStorage: WritableStorage {
  public func remove<T>(type: T.Type, for key: StorageKey) throws where T : Codable {
    keychain.delete(key.key)
  }
  
  public func save<T: Codable>(value: T, for key: StorageKey) throws {
    keychain.set(value.encode(), forKey: key.key)
  }
}

extension EncryptedStorage: ReadableStorage {
  public func fetchValue<T: Codable>(for key: StorageKey) -> T? {
    guard let value = (keychain.getData(key.key) ?? Data()).decode(T.self) else {
      return nil
    }
    
    return value
  }
}
