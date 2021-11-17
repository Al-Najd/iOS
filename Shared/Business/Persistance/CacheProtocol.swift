//
//  CacheProtocol.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Foundation

public protocol Cachable: Codable { }

public protocol ReadableStorage {
  func fetchValue<T: Cachable>(for key: StorageKey) throws -> T
}

public protocol WritableStorage {
  func save<T: Cachable>(value: T, for key: StorageKey) throws
  func remove<T: Cachable>(type: T.Type, for key: StorageKey) throws
}

public typealias Storage = ReadableStorage & WritableStorage

extension String: Cachable { }
extension Int: Cachable { }
extension Array: Cachable where Iterator.Element: Cachable { }
