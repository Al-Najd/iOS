//
//  CacheDataSource.swift
//  CAFU
//
//  Created by Ahmed Ramy on 19/09/2022.
//

import Foundation

// MARK: - ReadableCacheDataSource

protocol ReadableCacheDataSource {
    func value<T>(forKey key: CacheDataSourceKey, as type: T.Type) -> T?
    func object<T: Codable>(forKey key: CacheDataSourceKey, as type: T.Type) throws -> T?
    func bool(from key: CacheDataSourceKey) -> Bool
    func int(from key: CacheDataSourceKey) -> Int
    func string(from key: CacheDataSourceKey) -> String?
}

// MARK: - WriteableCacheDataSource

protocol WriteableCacheDataSource {
    func set<T: Any>(_ value: T?, for key: CacheDataSourceKey)
    func set(object value: Codable?, for key: CacheDataSourceKey) throws
    func set(bool value: Bool, for key: CacheDataSourceKey)
    func set(int value: Int, for key: CacheDataSourceKey)
    func set(string value: String, for key: CacheDataSourceKey)
    func remove(_ key: CacheDataSourceKey)
    func removeAll()
}

// MARK: - CacheDataSource

protocol CacheDataSource: ReadableCacheDataSource, WriteableCacheDataSource { }
