//
//  CacheProtocol.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Foundation
import Entity

public protocol ReadableStorage {
  func fetchValue<T: Codable>(for key: StorageKey) -> T?
}

public protocol WritableStorage {
  func save<T: Codable>(value: T, for key: StorageKey) throws
  func remove<T: Codable>(type: T.Type, for key: StorageKey) throws
}

public typealias Storage = ReadableStorage & WritableStorage
