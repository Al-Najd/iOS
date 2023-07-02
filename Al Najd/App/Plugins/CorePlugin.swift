//
//  CorePlugin.swift
//  The One
//
//  Created by Ahmed Ramy on 13/10/2021.
//


import ComposableArchitecture
import UIKit.UIApplication


// MARK: - CorePlugin

public struct CorePlugin: AppPlugin {
    @Dependency(\.cache)
    private var cache
    private var needsToSeedData: Bool { (cache.fetch(Bool.self, for: .didSeedData) ?? false) == false }

    public func setup() {
        DatabaseService.setupSchemes()
        if needsToSeedData {
            DatabaseService.seedDatabase()
            cache.save(true, for: .didSeedData)
        }
    }
}

extension StorageKey {
    static let didSeedData: StorageKey = .init(key: "didSeedData", suitableStorage: .userDefaults)
}
