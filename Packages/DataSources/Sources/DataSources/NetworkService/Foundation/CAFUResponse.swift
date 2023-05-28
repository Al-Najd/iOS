//
//  CAFUResponse.swift
//  CAFU
//
//  Created by Ahmed Ramy on 16/09/2022.
//

import Foundation
import Loggers

// MARK: - CAFUResponse

public struct CAFUResponse {
    public let data: Data
    public let statusCode: Int
    public let metadata: Metadata?

    public init(
        data: Data,
        statusCode: Int,
        metadata: Metadata? = nil) {
        self.data = data
        self.statusCode = statusCode
        self.metadata = metadata
    }
}

// MARK: CAFUResponse.Metadata

public extension CAFUResponse {
    /// Useful other data to help in debugging
    ///
    /// - Note: Can be expanded later on/changed without breaking new modules (OCP)
    struct Metadata {
        public let request: URLRequest?
        public let response: HTTPURLResponse?
        public let task: URLSessionTask?

        public init(
            request: URLRequest?,
            response: HTTPURLResponse?,
            task: URLSessionTask?) {
            self.request = request
            self.response = response
            self.task = task
        }
    }
}

// MARK: Loggable

extension CAFUResponse: Loggable {
    public var debugDescription: String {
        """
        Data (UTF8): \(data.description)
        Status Code: \(statusCode)
        Metadata: \(metadata?.debugDescription ?? .noneFound)
        """
    }
}

// MARK: - CAFUResponse.Metadata + Loggable

extension CAFUResponse.Metadata: Loggable {
    public var debugDescription: String {
        """
        Request: \(request?.description ?? .noneFound)
        Response: \(response?.debugDescription ?? .noneFound)
        """
    }
}

private extension String {
    static let noneFound = "🤷‍♂️ None Found"
}
