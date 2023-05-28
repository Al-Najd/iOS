//
//  PhoneNumberValidator.swift
//  CAFU
//
//  Created by Ahmed Ramy on 21/09/2022.
//

import Content
import Foundation
import Loggers
import PhoneNumberKit

// MARK: - CanValidatePhoneNumbers

public protocol CanValidatePhoneNumbers {
    func validate(_ number: PhoneNumber) throws
}

// MARK: - PhoneNumberValidator

public class PhoneNumberValidator: CanValidatePhoneNumbers {
    private let phoneNumberKit = PhoneNumberKit()

    public init() { }

    public func validate(_ phoneNumber: PhoneNumber) throws {
        do {
            _ = try phoneNumberKit.parse(phoneNumber.fullNumber)
        } catch let error as PhoneNumberError {
            throw error.toCAFUError()
        } catch {
            throw error
        }
    }
}

// MARK: - PhoneNumberValidatingError

public protocol PhoneNumberValidatingError: Error, Loggable, CustomStringConvertible { }

public extension PhoneNumberValidatingError {
    var debugDescription: String { description }
}

// MARK: - PhoneNumberUnknownValidatingError

public struct PhoneNumberUnknownValidatingError: Error, PhoneNumberValidatingError, CustomStringConvertible {
    let underlyingError: Error?

    public var description: String = L10n.validationPhoneNumberInvalidNumberSubtitle
}

// MARK: - PhoneNumberInvalidCountryCodeError

public struct PhoneNumberInvalidCountryCodeError: Error, PhoneNumberValidatingError {
    let countryCode: String

    public var description: String = L10n.validationPhoneNumberCountryCodeInvalidSubtitle
}

// MARK: - PhoneNumberNotANumberError

public struct PhoneNumberNotANumberError: Error, PhoneNumberValidatingError {
    let passedString: String

    public var description: String = L10n.validationPhoneNumberNumberMalformattedSubtitle
}

// MARK: - PhoneNumberTooShortError

struct PhoneNumberTooShortError: Error, PhoneNumberValidatingError {
    let number: String

    var description: String = L10n.validationPhoneNumberNumberTooShortSubtitle
}

// MARK: - PhoneNumberTooLongError

struct PhoneNumberTooLongError: Error, PhoneNumberValidatingError {
    let number: String

    var description: String = L10n.validationPhoneNumberNumberTooLongSubtitle
}
