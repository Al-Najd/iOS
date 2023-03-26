//
//  EncryptedStorage.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Entity
import Foundation
import KeychainSwift

// MARK: - EncryptedStorage

public final class EncryptedStorage {
    private let keychain = KeychainSwift()
}

// MARK: WritableStorage

extension EncryptedStorage: WritableStorage {
    public func remove<T>(type _: T.Type, for key: StorageKey) throws where T: Codable {
        keychain.delete(key.key)
    }

    public func save<T: Codable>(value: T, for key: StorageKey) throws {
        keychain.set(value.encode(), forKey: key.key)
    }
}

// MARK: ReadableStorage

extension EncryptedStorage: ReadableStorage {
    public func fetchValue<T: Codable>(for key: StorageKey) -> T? {
        guard let value = (keychain.getData(key.key) ?? Data()).decode(T.self) else {
            return nil
        }

        return value
    }
}