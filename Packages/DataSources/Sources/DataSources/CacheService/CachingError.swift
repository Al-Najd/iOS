//
//  CachingError.swift
//  CAFU
//
//  Created by Ahmed Ramy on 19/09/2022.
//

import Foundation

// MARK: - CacheError

protocol CacheError: Error { }

// MARK: - CacheNotFound

struct CacheNotFound: Error, CacheError {
    let key: CacheDataSourceKey
    let expectedType: Codable.Type

    init(
        key: CacheDataSourceKey,
        expectedType: Codable.Type) {
        self.key = key
        self.expectedType = expectedType
    }
}

// MARK: - CacheSaveFailed

struct CacheSaveFailed: Error, CacheError {
    let value: Codable?
    let underlyingError: Error

    init(value: Codable?, underlyingError: Error) {
        self.value = value
        self.underlyingError = underlyingError
    }
}
