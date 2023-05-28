//
//  File.swift
//
//
//  Created by Ahmed Ramy on 31/03/2023.
//

import Factory
import Foundation

// MARK: - Configs
public extension Container {
    var marketConfig: Factory<MarketConfigurable> { self { MarketConfig() }.singleton }
    var applePayConfig: Factory<ApplePayConfigurable> { self { ApplePayConfig() }.singleton }
    var authConfig: Factory<AuthenticationConfigurable> { self { AuthenticationConfig() }.singleton }
    var networkConfig: Factory<NetworkConfigurable> { self { NetworkConfig() }.singleton }
    var cacheConfig: Factory<CacheConfigurable> { self { CacheConfig() }.singleton }
}
