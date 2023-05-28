//
//  CacheWrapper.swift
//  CAFU
//
//  Created by Ahmed Allam on 28/10/2022.
//

import Combine
import Factory
import Foundation

// MARK: - CacheWrapper

@propertyWrapper
public class CacheWrapper<Value> {
    @Injected(\.cache)
    public var cacheService

    public let key: CacheDataSourceKey
    public let defaultValue: Value
    public let publisher = PassthroughSubject<Value, Never>()

    public init(key: CacheDataSourceKey, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: Value {
        get {
            cacheService.value(forKey: key, as: Value.self, storage: key.source) ?? defaultValue
        }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                cacheService.remove(key, storage: key.source)
            } else {
                cacheService.set(newValue, for: key, storage: key.source)
            }
            publisher.send(newValue)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        publisher.eraseToAnyPublisher()
    }
}

public extension CacheWrapper where Value: ExpressibleByNilLiteral {
    /// Creates a new User Defaults property wrapper for the given key.
    /// - Parameters:
    ///   - key: The key to use with the user defaults store.
    convenience init(key: CacheDataSourceKey) {
        self.init(key: key, defaultValue: nil)
    }
}

// MARK: - AnyOptional

/// Allows to match for optionals with generics that are defined as non-optional.
public protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}

// MARK: - Optional + AnyOptional

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
