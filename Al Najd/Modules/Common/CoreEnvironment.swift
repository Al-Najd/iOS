//
//  SystemEnvironment.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 27/01/2022.
//

import ComposableArchitecture
import Foundation

// MARK: - CacheManager + DependencyKey

extension CacheManager: DependencyKey {
    public static let liveValue = CacheManager()
}

public extension DependencyValues {
    var cache: CacheManager {
        get { self[CacheManager.self] }
        set { self[CacheManager.self] = newValue }
    }
}
