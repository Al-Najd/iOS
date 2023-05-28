//
//  UserDefaultsService.swift
//  CAFU
//
//  Created by Ahmed Ramy on 19/09/2022.
//

import Configs
import Foundation
import Loggers

// MARK: - UserDefaultsDataSource

final class UserDefaultsDataSource: CacheDataSource {
    private let defaults: UserDefaults

    init(_ defaults: UserDefaults = CacheConfig.UserDefaultsConfig.userDefaults) {
        self.defaults = defaults
    }
}

// MARK: - Reading Methods
extension UserDefaultsDataSource {
    func value<T>(forKey key: CacheDataSourceKey, as _: T.Type) -> T? {
        defaults.value(forKey: key.rawValue) as? T
    }

    func object<T>(forKey key: CacheDataSourceKey, as type: T.Type) throws -> T? where T: Decodable, T: Encodable {
        do {
            return try defaults.data(forKey: key.rawValue)?.decode(type)
        } catch {
            Log.error(
                """
                Failed to Decode an Object of type \(T.self) for key: \(key) when fetching from cache,

                Error Summary: \(error.debugDescription)

                Details:
                \(error)
                """,
                tags: [.cache])
            throw CacheNotFound(key: key, expectedType: type)
        }
    }

    func bool(from key: CacheDataSourceKey) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }

    func int(from key: CacheDataSourceKey) -> Int {
        defaults.integer(forKey: key.rawValue)
    }

    func string(from key: CacheDataSourceKey) -> String? {
        defaults.string(forKey: key.rawValue)
    }
}

// MARK: - Writing Methods
extension UserDefaultsDataSource {
    func set<T>(_ value: T?, for key: CacheDataSourceKey) {
        defaults.set(value, forKey: key.rawValue)
    }

    func set(object value: Codable?, for key: CacheDataSourceKey) throws {
        do {
            defaults.set(try value?.encode(), forKey: key.rawValue)
        } catch {
            throw CacheSaveFailed(value: value, underlyingError: error)
        }
    }

    func set(bool value: Bool, for key: CacheDataSourceKey) {
        defaults.set(value, forKey: key.rawValue)
    }

    func set(int value: Int, for key: CacheDataSourceKey) {
        defaults.set(value, forKey: key.rawValue)
    }

    func set(string value: String, for key: CacheDataSourceKey) {
        defaults.set(value, forKey: key.rawValue)
    }

    func remove(_ key: CacheDataSourceKey) {
        defaults.removeObject(forKey: key.rawValue)
    }

    func removeAll() {
        CacheDataSourceKey.allCases.forEach {
            defaults.removeObject(forKey: $0.rawValue)
        }
    }
}

// MARK: - CacheConfig.UserDefaultsConfig

public extension CacheConfig {
    enum UserDefaultsConfig {
        static let userDefaults: UserDefaults = {
            let suffix = ".user-defaults"
            let fallbackBundleID = "com.cafu.ev.customer"
            let identifier: String = Bundle.main.bundleIdentifier ?? fallbackBundleID

            return UserDefaults(suiteName: identifier) ?? .standard
        }()
    }
}
