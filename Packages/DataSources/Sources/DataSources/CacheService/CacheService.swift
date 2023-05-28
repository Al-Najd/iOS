//
//  CacheService.swift
//  CAFU
//
//  Created by Ahmed Ramy on 24/09/2022.
//

import Foundation

// MARK: - WritableCacheServiceProtocol

public protocol WritableCacheServiceProtocol {
    func set<T>(_ value: T?, for key: CacheDataSourceKey, storage: StorageType)
    func set(object value: Codable?, for key: CacheDataSourceKey, storage: StorageType) throws

    func remove(_ key: CacheDataSourceKey, storage: StorageType)
    func removeAll(in source: StorageType)
}

public extension WritableCacheServiceProtocol {
    func set<T: Any>(_ value: T?, for key: CacheDataSourceKey) {
        set(value, for: key, storage: key.source)
    }

    func set(object value: Codable?, for key: CacheDataSourceKey) throws {
        try set(object: value, for: key, storage: key.source)
    }

    func remove(_ key: CacheDataSourceKey) {
        remove(key, storage: key.source)
    }

    func removeAll() {
        removeAll(in: .defaults)
        removeAll(in: .keychain)
    }

    func removeSensitiveData() {
        remove(.authToken)
        remove(.currentUser)
        remove(.fcmToken)
    }
}

// MARK: - ReadableCacheServiceProtocol

public protocol ReadableCacheServiceProtocol {
    func value<T: Any>(forKey key: CacheDataSourceKey, as type: T.Type, storage: StorageType) -> T?
    func object<T: Codable>(forKey key: CacheDataSourceKey, as type: T.Type, storage: StorageType) throws -> T?
}

public extension ReadableCacheServiceProtocol {
    func value<T: Any>(forKey key: CacheDataSourceKey, as type: T.Type) -> T? {
        value(forKey: key, as: type, storage: key.source)
    }

    func object<T: Codable>(forKey key: CacheDataSourceKey, as type: T.Type) throws -> T? {
        try object(forKey: key, as: type, storage: key.source)
    }
}

// MARK: - CacheServiceProtocol

// sourcery: AutoMockable
public protocol CacheServiceProtocol: ReadableCacheServiceProtocol, WritableCacheServiceProtocol { }

// MARK: - CacheService

public class CacheService: CacheServiceProtocol {
    private let userDefaultsSource: UserDefaultsDataSource = .init()
    private let keychainSource: KeychainDataSource = .init()
}

// MARK: - Reading Methods
public extension CacheService {
    func value<T>(forKey key: CacheDataSourceKey, as type: T.Type, storage: StorageType) -> T? {
        getReadableSource(from: storage).value(forKey: key, as: type)
    }

    func object<T: Codable>(forKey key: CacheDataSourceKey, as type: T.Type, storage: StorageType) throws -> T? {
        try getReadableSource(from: storage).object(forKey: key, as: type)
    }
}

// MARK: - Writing Methods
public extension CacheService {
    func set<T>(_ value: T?, for key: CacheDataSourceKey, storage: StorageType) {
        getWritableSource(from: storage).set(value, for: key)
    }

    func set(object value: Codable?, for key: CacheDataSourceKey, storage: StorageType) throws {
        try getWritableSource(from: storage).set(object: value, for: key)
    }

    func remove(_ key: CacheDataSourceKey, storage: StorageType) {
        getWritableSource(from: storage).remove(key)
    }

    func removeAll(in source: StorageType) {
        getWritableSource(from: source).removeAll()
    }
}

private extension CacheService {
    func getReadableSource(from source: StorageType) -> ReadableCacheDataSource {
        switch source {
        case .defaults:
            return userDefaultsSource
        case .keychain:
            return keychainSource
        }
    }

    func getWritableSource(from source: StorageType) -> WriteableCacheDataSource {
        switch source {
        case .defaults:
            return userDefaultsSource
        case .keychain:
            return keychainSource
        }
    }
}
