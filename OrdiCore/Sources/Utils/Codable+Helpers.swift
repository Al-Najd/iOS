//
//  Codable+Helpers.swift
//  Proba B.V.
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Proba B.V. All rights reserved.
//

import Foundation
import OrdiLogging

public extension Encodable {
    func asDictionary() -> [String: Any] {
        let serialized = (try? JSONSerialization.jsonObject(with: self.encode(), options: .allowFragments)) ?? nil
        return serialized as? [String: Any] ?? [String: Any]()
    }
    
    func encode() -> Data {
        return (try? JSONEncoder().encode(self)) ?? Data()
    }
}

public extension Data {
    func decode<T: Decodable>(_ object: T.Type) -> T? {
        do {
            return (try JSONDecoder().decode(object, from: self))
        } catch {
            LoggersManager.error(message: "Failed to Parse Object with this type: \(object)\nError: \(error)")
            return nil
        }
    }
}
