//
//  CAFUJSONDecoder.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import Foundation
import Loggers

// MARK: - CAFUJSONDecoder

public final class CAFUJSONDecoder: JSONDecoder {
    override public init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
        dateDecodingStrategy = .iso8601
    }

    override public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            return try super.decode(type, from: data)
        } catch let error as DecodingError {
            throw error.whileLogging([.parsing])
        } catch {
            throw error.whileLogging([.parsing])
        }
    }
}

public extension Data {
    func decodeOrNil<T: Decodable>(_ type: T.Type) -> T? {
        try? CAFUJSONDecoder().decode(type, from: self)
    }

    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        try CAFUJSONDecoder().decode(type, from: self)
    }
}

// MARK: - DecodingError + Loggable

extension DecodingError: Loggable {
    public var debugDescription: String {
        let message: (_ body: String) -> String = {
            """
            Decoding Failure Occured

            ---

            \($0)
            """
        }

        switch self {
        case .typeMismatch(let type, let context):
            return message(makeTypeMismatchMessage(type, context))
        case .valueNotFound(let value, let context):
            return message(makeValueNotFoundBodyMessage(value, context))
        case .keyNotFound(let key, let context):
            return message(makeKeyNotFoundBodyMessage(key, context))
        case .dataCorrupted(let context):
            return message(makeDataCorrupted(context))
        @unknown default:
            return message(makeUnknownDecodingErrorReason(self))
        }
    }

    private func makeKeyNotFoundBodyMessage(_ key: CodingKey, _ context: DecodingError.Context) -> String {
        """
        [Key Not Found]

        Could not find this key [\(key.stringValue)] in JSON required for parsing

        Context:
         keyPath: \(context.codingPath)
        debugDescription: \(context.debugDescription)
        """
    }

    private func makeValueNotFoundBodyMessage(_ value: Any, _ context: DecodingError.Context) -> String {
        """
        [Value Not Found]

        This value [\(value)] was not found in JSON required for parsing

        Context:
        keyPath: \(context.codingPath)
        debugDescription: \(context.debugDescription)"
        """
    }

    private func makeTypeMismatchMessage(_ type: Any, _ context: DecodingError.Context) -> String {
        """
        [Type Mismatch]

        This type [\(type)] was mismatched in JSON required for parsing

        Context Summary:
        keyPath: \(context.codingPath)
        debugDescription: \(context.debugDescription)

        Context: \(context)
        """
    }

    private func makeDataCorrupted(_ context: DecodingError.Context) -> String {
        """
        [Data Corrupted]

        Data was corrupted and undecodable

        Context:
        keyPath: \(context.codingPath)
        debugDescription: \(context.debugDescription)

        """
    }

    private func makeUnknownDecodingErrorReason(_ error: DecodingError) -> String {
        """
        [Unknown Decoding Failure Reason]

        Data failed decoding for an unknown reason

        Error:
        \(error)
        """
    }
}
