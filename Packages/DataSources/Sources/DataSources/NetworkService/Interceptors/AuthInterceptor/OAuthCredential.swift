//
//  OAuthCredential.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Alamofire
import Configs
import Factory
import Foundation
import Loggers

// MARK: - OAuthCredential

public final class OAuthCredential: Codable, AuthenticationCredential {
    public let type: String
    public let accessToken: String
    public let expiryDate: Date
    public let refreshToken: String
    public var token: String {
        accessToken
    }

    #if DEBUG
    @CodableCacheWrapper(key: .shouldAllowRefreshAuthToken, defaultValue: false)
    public var shouldAllowRefreshAuthToken: Bool
    #endif

    // Require refresh if within 5 minutes of expiration
    public var requiresRefresh: Bool {
        #if DEBUG
        shouldAllowRefreshAuthToken
            ? Date(timeIntervalSinceNow: Container.shared.networkConfig().tokenRefreshWindowInterval) > expiryDate
            : false
        #else
        Date(timeIntervalSinceNow: Container.shared.networkConfig().tokenRefreshWindowInterval) > expiryDate
        #endif
    }

    enum CodingKeys: String, CodingKey {
        case type
        case accessToken
        case refreshToken
        case expiryDate = "expiresAt"
    }

    public init(
        type: String,
        accessToken: String,
        expiryDate: Date,
        refreshToken: String) {
        self.type = type
        self.accessToken = accessToken
        self.expiryDate = expiryDate
        self.refreshToken = refreshToken
    }

    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<OAuthCredential.CodingKeys> = try decoder
            .container(keyedBy: OAuthCredential.CodingKeys.self)

        type = try container.decode(String.self, forKey: .type)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        refreshToken = try container.decode(String.self, forKey: .refreshToken)
        expiryDate = try container.decode(Date.self, forKey: .expiryDate)
    }

    public final func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<OAuthCredential.CodingKeys> = encoder
            .container(keyedBy: OAuthCredential.CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(accessToken, forKey: .accessToken)
        try container.encode(refreshToken, forKey: .refreshToken)
        try container.encode(expiryDate, forKey: .expiryDate)
    }
}

// MARK: - RefreshTokenRequest

public struct RefreshTokenRequest: Encodable {
    let grantType = "refresh_token"
    let refreshToken: String
}

// MARK: - OAuthCredential + Loggable

extension OAuthCredential: Loggable {
    public var debugDescription: String {
        """
        Access Token: \(token)
        Expiry Date: \(expiryDate.description)")
        Refresh Token: \(refreshToken)
        """
    }
}
