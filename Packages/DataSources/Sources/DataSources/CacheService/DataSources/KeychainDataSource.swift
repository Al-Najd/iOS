//
//  KeychainService.swift
//  CAFU
//
//  Created by Ahmed Ramy on 19/09/2022.
//

import Configs
import Foundation
import SwiftKeychainWrapper

// MARK: - KeychainDataSource

final class KeychainDataSource: CacheDataSource {
    private let keychain: KeychainWrapper

    init(_ keychain: KeychainWrapper = CacheConfig.Keychain.keychain) {
        self.keychain = keychain
    }
}

// MARK: - Reading Methods
extension KeychainDataSource {
    func value<T>(forKey key: CacheDataSourceKey, as type: T.Type) -> T? {
        switch type {
        case is String.Type:
            return string(from: key) as? T
        case is Bool.Type:
            return bool(from: key) as? T
        case is Int.Type:
            return int(from: key) as? T
        default:
            return nil
        }
    }

    func object<T: Codable>(forKey key: CacheDataSourceKey, as type: T.Type) throws -> T? {
        guard let value = keychain.data(forKey: key.rawValue)?.decodeOrNil(type) else {
            throw CacheNotFound(
                key: key,
                expectedType: type)
        }

        return value
    }

    func bool(from key: CacheDataSourceKey) -> Bool {
        keychain.bool(forKey: key.rawValue) ?? false
    }

    func int(from key: CacheDataSourceKey) -> Int {
        keychain.integer(forKey: key.rawValue) ?? 0
    }

    func string(from key: CacheDataSourceKey) -> String? {
        keychain.string(forKey: key.rawValue)
    }
}

// MARK: - Writing Methods
extension KeychainDataSource {
    func set<T>(_ value: T?, for key: CacheDataSourceKey) {
        guard let value else {
            remove(key)
            return
        }
        if let value = value as? Codable {
            try? set(object: value, for: key)
        } else if let value = value as? String {
            set(string: value, for: key)
        } else if let value = value as? Int {
            set(int: value, for: key)
        } else if let value = value as? Bool {
            set(bool: value, for: key)
        }
    }

    func set(object value: Codable?, for key: CacheDataSourceKey) throws {
        do {
            if let data = try value?.encode() {
                keychain.set(data, forKey: key.rawValue)
            }
        } catch {
            throw CacheSaveFailed(value: value, underlyingError: error)
        }
    }

    func set(bool value: Bool, for key: CacheDataSourceKey) {
        keychain.set(value, forKey: key.rawValue)
    }

    func set(int value: Int, for key: CacheDataSourceKey) {
        keychain.set(value, forKey: key.rawValue)
    }

    func set(string value: String, for key: CacheDataSourceKey) {
        keychain.set(value, forKey: key.rawValue)
    }

    func remove(_ key: CacheDataSourceKey) {
        keychain.removeObject(forKey: key.rawValue)
    }

    func removeAll() {
        CacheDataSourceKey.allCases.forEach {
            keychain.removeObject(forKey: $0.rawValue)
        }
    }
}

// MARK: - CacheConfig.Keychain

extension CacheConfig {
    enum Keychain {
        static let accessGroup: String? = nil

        static let keychain: KeychainWrapper = {
            let suffix = ".user-defaults"
            let fallbackBundleID = "com.cafu.ev.customer"
            let identifier: String = Bundle.main.bundleIdentifier ?? fallbackBundleID

            return KeychainWrapper(serviceName: identifier, accessGroup: accessGroup)
        }()
    }
}
