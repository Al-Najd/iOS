//
//  PhoneNumber.swift
//  CAFU
//
//  Created by Ahmed Ramy on 21/09/2022.
//

import Configs
import Factory
import Foundation
import Loggers

// MARK: - PhoneNumber

public struct PhoneNumber {
    public let countryCode: String
    public let number: String

    private let validator = PhoneNumberValidator()

    public var fullNumber: String { "\(countryCode)\(number)" }

    public var isValid: Bool {
        do {
            try validator.validate(self)
            return true
        } catch {
            return false
        }
    }

    public init(
        countryCode: String = Container.shared.authConfig().countryCode,
        number: String) {
        self.countryCode = countryCode.replacingOccurrences(of: "+", with: "")
        self.number = number
    }
}

// MARK: Equatable

extension PhoneNumber: Equatable {
    public static func == (lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
        lhs.countryCode == rhs.countryCode &&
            lhs.number == rhs.number
    }
}

// MARK: Encodable

extension PhoneNumber: Encodable {
    enum CodingKeys: String, CodingKey {
        case countryCode = "phone_code"
        case number
    }
}
