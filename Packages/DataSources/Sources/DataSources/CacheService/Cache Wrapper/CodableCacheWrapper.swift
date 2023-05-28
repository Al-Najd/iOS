//
//  CodableCacheWrapper.swift
//  CAFU
//
//  Created by Ahmed Allam on 28/10/2022.
//

import Combine
import Factory
import Foundation
import Loggers

// MARK: - CodableCacheWrapper

@propertyWrapper
public class CodableCacheWrapper<Value: Codable> {
    let key: CacheDataSourceKey
    let defaultValue: Value
    @Injected(\.cache)
    private var cacheService

    public init(key: CacheDataSourceKey, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }

    let publisher = PassthroughSubject<Value, Never>()

    public var wrappedValue: Value {
        get {
            do {
                return try cacheService.object(forKey: key, as: Value.self, storage: key.source) ?? defaultValue
            } catch {
                print(error)
                return defaultValue
            }
        }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                cacheService.remove(key, storage: key.source)
            } else {
                do {
                    try cacheService.set(object: newValue, for: key, storage: key.source)
                } catch {
                    Log.error("Object `\(String(describing: newValue.self))` can't be saved using `CodableCacheWrapper`")
                }
            }
            publisher.send(newValue)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        publisher.eraseToAnyPublisher()
    }
}

public extension CodableCacheWrapper where Value: ExpressibleByNilLiteral {
    /// Creates a new User Defaults property wrapper for the given key.
    /// - Parameters:
    ///   - key: The key to use with the user defaults store.
    convenience init(key: CacheDataSourceKey) {
        self.init(key: key, defaultValue: nil)
    }
}
