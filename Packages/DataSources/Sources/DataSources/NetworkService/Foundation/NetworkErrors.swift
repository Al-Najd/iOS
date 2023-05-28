//
//  NetworkErrors.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import Foundation
import Loggers

// MARK: - PoC_NetworkError

public enum PoC_NetworkError: Error {
    case cancelled
    case unreachable
}

// MARK: - NetworkError

public protocol NetworkError: Error, Loggable { }

public extension NetworkError {
    var debugDescription: String {
        """
        Network Failure Error Occured

        \(localizedDescription)

        ---

        \(self)
        """
    }
}

// MARK: - CancelledError

public struct CancelledError: Error, NetworkError {
    public var debugDescription: String {
        "Request has been cancelled"
    }
}

// MARK: - UnauthorizedError

public struct UnauthorizedError: Error, NetworkError {
    public var debugDescription: String {
        "Unauthorized error occured"
    }
}

// MARK: - UnreachableError

public struct UnreachableError: Error, NetworkError {
    public var debugDescription: String {
        "Network is Unreachable"
    }
}

// MARK: - UnmapableResponseError

public struct UnmapableResponseError: Error, NetworkError {
    public let response: CAFUResponse
    public let decodingError: DecodingError?

    public init(
        _ response: CAFUResponse,
        _ decodingError: DecodingError? = nil) {
        self.response = response
        self.decodingError = decodingError
    }

    public var debugDescription: String {
        """
        Decoding Error occured

        ---
        Error:
        \(decodingError.debugDescription)

        ---
        Response:
        \(response.debugDescription)
        """
    }
}

// MARK: - UnknownNetworkError

public struct UnknownNetworkError: Error, NetworkError {
    let underlyingError: Error?

    public var debugDescription: String {
        if let underlyingError {
            return """
                Unknown Network Error Occured
                Error Description: \(underlyingError.localizedDescription)

                ---

                Error Object: \(underlyingError)
                """
        } else {
            return "Unknown Network Error Occured"
        }
    }

    init(underlyingError: Error? = nil) {
        self.underlyingError = underlyingError
    }
}

// MARK: - RetryFailureNetworkError

public struct RetryFailureNetworkError: Error, NetworkError, Loggable {
    let retryError: Loggable
    let originalError: Loggable

    public var debugDescription: String {
        """
        Failed to retry Network Request

        ---
        Retry Error: \(retryError.debugDescription)

        ---
        Original Error: \(originalError.debugDescription)
        """
    }
}

// MARK: - NetworkAuthError

public enum NetworkAuthError: NetworkError {
    case excessiveRefresh
    case missingCredentials

    public var debugDescription: String {
        switch self {
        case .excessiveRefresh:
            return """
                Failed to authenticate due to many token refresh retries
                """
        case .missingCredentials:
            return """
                Failed to authenticate due to missing credentials
                """
        }
    }
}

// MARK: - ResponseValidationNetworkError

public struct ResponseValidationNetworkError: Error, NetworkError {
    let reason: Reason
}

// MARK: ResponseValidationNetworkError.Reason

public extension ResponseValidationNetworkError {
    enum Reason {
        /// The response did not contain a `Content-Type` and the `acceptableContentTypes` provided did not contain a
        /// wildcard type.
        case missingContentType(acceptableContentTypes: [String])
        /// The response `Content-Type` did not match any type in the provided `acceptableContentTypes`.
        case unacceptableContentType(acceptableContentTypes: [String], responseContentType: String)

        case unknown
    }
}
