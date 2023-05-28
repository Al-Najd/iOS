//
//  CacheDataSourceKey.swift
//  CAFU
//
//  Created by Ahmed Ramy on 20/09/2022.
//

import Foundation

// MARK: - CacheDataSourceKey

public enum CacheDataSourceKey: String, CaseIterable {
    case didSeeOnboarding
    case isLoggedIn
    case authToken
    /// will contain the latest clicked order `id` after user click on low charge popup
    case mockURL
    case currentUser

    // MARK: - Debug View Properties
    case shouldUseMockUrl
    case shouldAllowRefreshAuthToken
    case shouldSwitchToUAE
    case shouldUseRemoteZonesConfig
    case isSmartcarConnected

    /// Will control whether to launch Smartcar in live or simulated mode
    case isSmartCarSimulatedMode

    case fcmToken

    // MARK: - smartcar assets
    case socPercentage

    public var source: StorageType {
        switch self {
        case .authToken:
            #if DEBUG || REVIEW
            return .defaults
            #else
            return .keychain
            #endif
        default:
            return .defaults
        }
    }
}

// MARK: - StorageType

public enum StorageType {
    case defaults
    case keychain
}
