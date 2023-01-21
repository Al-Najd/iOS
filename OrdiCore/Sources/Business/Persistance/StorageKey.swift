//
//  CachingKey.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Entity
import Foundation

public struct StorageKey {
    public let key: String
    public let suitableStorage: CacheManager.SupportedStorage

    public init(key: String, suitableStorage: CacheManager.SupportedStorage) {
        self.key = key
        self.suitableStorage = suitableStorage
    }
}
