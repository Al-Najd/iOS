//
//  CAFUResponseDecoder.swift
//  CAFU
//
//  Created by Ahmed Ramy on 16/09/2022.
//

import Foundation
import Loggers

// MARK: - CAFUResponseDecoder

public final class CAFUResponseDecoder {
    static let `default`: CAFUResponseDecoder = .init()

    public func decode<T: Decodable>(
        _ response: CAFUResponse,
        as expectedType: T.Type) throws
        -> T {
        try decodeAsNoContent(expectedType) ?? decodeAsExpectedType(response, as: expectedType)
    }

    private func decodeAsNoContent<T: Decodable>(_ expectedType: T.Type) -> T? {
        NoContentResponse() as? T
    }

    private func decodeAsExpectedType<T: Decodable>(_ response: CAFUResponse, as expectedType: T.Type) throws -> T {
        do {
            return try CAFUJSONDecoder().decode(expectedType, from: response.data)
        } catch {
            if let task = response.metadata?.task {
                Log.networkDecodingFailed(for: task, with: error as? DecodingError, for: expectedType)
            }
            throw UnmapableResponseError(response, error as? DecodingError)
        }
    }
}

public extension CAFUResponse {
    func decode<T: Decodable>(
        as expectedType: T.Type) throws
        -> T {
        if statusCode.isInSuccessRange {
            return try CAFUResponseDecoder.default.decode(self, as: expectedType)
        } else {
            throw try CAFUResponseDecoder.default.decode(self, as: ErrorResponse.self).whileLogging([.network])
        }
    }

    func decode<T: Decodable>(
        onSuccessAs expectedType: T.Type,
        onFailure errorTypePerStatusCode: [Int: DecodableError.Type]) throws
        -> T {
        if statusCode.isInSuccessRange {
            return try CAFUResponseDecoder.default.decode(self, as: expectedType)
        } else if let errorType = errorTypePerStatusCode[statusCode] {
            throw try CAFUResponseDecoder.default.decode(self, as: errorType)
        } else {
            throw try CAFUResponseDecoder.default.decode(self, as: ErrorResponse.self).whileLogging()
        }
    }

    /// Tries to decode to expected type, but in case a specific status code was met, it will throw the instructed error to handle along the error handling pipeline
    ///
    /// - Note: You may be wondering why this is helpful, In case the client side wants to recover using only a `statusCode`, it can throw an internal error to have the pipeline recover
    ///         like the `decode<T:>(onSuccessAs:, onFailure:)` which does the same idea, but instead of depending only on the `statusCode` to tell you what to do, we also need some data to know how
    ///         to handle the incoming error from the network
    func decode<T: Decodable>(
        onSuccessAs expectedType: T.Type,
        onStatusCodeThrow errorPerStatusCode: [Int: Error]) throws
        -> T {
        if let errorToThrow = errorPerStatusCode[statusCode] {
            throw errorToThrow
        } else if statusCode.isInSuccessRange {
            return try CAFUResponseDecoder.default.decode(self, as: expectedType)
        } else {
            throw try CAFUResponseDecoder.default.decode(self, as: ErrorResponse.self).whileLogging()
        }
    }
}

private extension Int {
    var isInSuccessRange: Bool {
        (200...399).contains(self)
    }
}

// MARK: - DecodableError

public protocol DecodableError: Error, Decodable { }

// MARK: - NoContentResponse

public class NoContentResponse: Decodable { }
