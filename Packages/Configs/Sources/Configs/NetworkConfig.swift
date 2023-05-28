//
//  NetworkConfig.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Foundation

// MARK: - NetworkConfigurable

public protocol NetworkConfigurable {
    var baseURL: String { get set }
    var defaultHeaders: [String: String] { get set }

    /// Delay between Retries in Seconds (10)
    var retryDelay: TimeInterval { get }

    /// Limit on how many retries allowed for single request
    var retryLimit: Int { get }

    /// Multiplier between retry & delay to create exponential back off to not spam aimlessly
    var retryDelayMultiplier: Double { get }

    /// Expires every 24 hrs
    var tokenExpiryInterval: TimeInterval { get }

    /// Window used to refresh token before expiry (Before expiry by **5 mins**)
    var tokenRefreshWindowInterval: TimeInterval { get }

    var requestTimeOut: TimeInterval { get }
    var resourcesTimeOut: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var urlCache: URLCache? { get }
    var sessionConfig: URLSessionConfiguration { get }
    var rootQueueID: String { get }
    var encodingMemoryThreshold: UInt64 { get }
}

// MARK: - NetworkConfig

public class NetworkConfig: NetworkConfigurable {
    public var baseURL: String
    public var defaultHeaders: [String : String]

    // MARK: - Retry
    /// Delay between Retries in Seconds (10)
    public let retryDelay: TimeInterval

    /// Limit on how many retries allowed for single request
    public let retryLimit: Int

    /// Multiplier between retry & delay to create exponential back off to not spam aimlessly
    public let retryDelayMultiplier: Double

    // MARK: - OAuth
    /// Expires every 24 hrs
    public let tokenExpiryInterval: TimeInterval

    /// Window used to refresh token before expiry (Before expiry by **5 mins**)
    public let tokenRefreshWindowInterval: TimeInterval

    // MARK: - Session Configurations
    public let requestTimeOut: TimeInterval
    public let resourcesTimeOut: TimeInterval
    public let cachePolicy: URLRequest.CachePolicy
    public let urlCache: URLCache?
    public let sessionConfig: URLSessionConfiguration
    public let rootQueueID: String
    public let encodingMemoryThreshold: UInt64

    public init(
        baseURL: String = "Change Me from your App Configs 😛",
        defaultHeaders: [String: String] = ["Accept": "application/json"],
        retryDelay: TimeInterval = 10,
        retryLimit: Int = 5,
        retryDelayMultiplier: Double = 1.1,
        tokenExpiryInterval: TimeInterval = 24 * 60 * 60,
        tokenRefreshWindowInterval: TimeInterval = 5 * 60,
        requestTimeOut: TimeInterval = 30.0,
        resourcesTimeOut: TimeInterval = 300.0,
        cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData,
        urlCache: URLCache? = nil,
        encodingMemoryThreshold: UInt64 = 10_000_000) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
        self.retryDelay = retryDelay
        self.retryLimit = retryLimit
        self.retryDelayMultiplier = retryDelayMultiplier
        self.tokenExpiryInterval = tokenExpiryInterval
        self.tokenRefreshWindowInterval = tokenRefreshWindowInterval
        self.requestTimeOut = requestTimeOut
        self.resourcesTimeOut = resourcesTimeOut
        self.cachePolicy = cachePolicy
        self.urlCache = urlCache
        sessionConfig = {
            let config: URLSessionConfiguration = .default

            config.timeoutIntervalForRequest = requestTimeOut
            config.timeoutIntervalForResource = resourcesTimeOut
            config.requestCachePolicy = cachePolicy
            config.urlCache = urlCache

            return config
        }()
        rootQueueID = (Bundle.main.bundleIdentifier ?? "com.cafu").appending(".network.session.rootQueue")
        self.encodingMemoryThreshold = encodingMemoryThreshold
    }
}
