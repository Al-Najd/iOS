//
//  CacheProtocol.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Entity
import Foundation

// MARK: - ReadableStorage

public protocol ReadableStorage {
    func fetchValue<T: Codable>(for key: StorageKey) -> T?
}

// MARK: - WritableStorage

public protocol WritableStorage {
    func save<T: Codable>(value: T, for key: StorageKey) throws
    func remove<T: Codable>(type: T.Type, for key: StorageKey) throws
}

public typealias Storage = ReadableStorage & WritableStorage
