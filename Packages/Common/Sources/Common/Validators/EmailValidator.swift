//
//  EmailValidator.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 13/10/2022.
//

import Foundation

// MARK: - EmailValidatorProtocol

public protocol EmailValidatorProtocol {
    func validate(_ email: String) throws
}

// MARK: - EmailValidator

public class EmailValidator: EmailValidatorProtocol {
    public init() { }

    public func validate(_: String) throws {
        do {
            _ = try NSRegularExpression(pattern: ValidationConfig.emailRegex, options: .caseInsensitive)
        } catch let error {
            throw ValidationError(dataSourceError: error)
        }
    }
}

// MARK: - ValidationError

public class ValidationError: Error {
    public init(dataSourceError: Error? = nil) {
        self.dataSourceError = dataSourceError
    }

    var dataSourceError: Error?
}
