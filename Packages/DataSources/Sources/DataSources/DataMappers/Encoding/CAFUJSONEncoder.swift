//
//  CAFUJSONEncoder.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import Foundation
import Loggers

// MARK: - CAFUJSONEncoder

public final class CAFUJSONEncoder: JSONEncoder {
    override init() {
        super.init()
        keyEncodingStrategy = .convertToSnakeCase
        dateEncodingStrategy = .iso8601
    }
}

public extension Encodable {
    func asDictionary() -> [String: Any] {
        let serialized = (try? JSONSerialization.jsonObject(with: encode(), options: .allowFragments)) ?? nil
        return serialized as? [String: Any] ?? [String: Any]()
    }

    func encode() throws -> Data {
        do {
            return try CAFUJSONEncoder().encode(self)
        } catch EncodingError.invalidValue(let value, let context) {
            Log.error("\(value) \(context)", tags: [.encoding])
            throw EncodingError.invalidValue(value, context)
        } catch {
            Log.error("\(error)", tags: [.encoding])
            throw error
        }
    }
}

public extension Dictionary {
    func encode() throws -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self)
        } catch {
            throw error.whileLogging([.encoding])
        }
    }
}
