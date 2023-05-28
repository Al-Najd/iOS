//
//  PhoneNumberKit+Adapters.swift
//  CAFU
//
//  Created by Ahmed Ramy on 21/09/2022.
//

import PhoneNumberKit

extension PhoneNumberError {
    func toCAFUError() -> PhoneNumberValidatingError {
        switch self {
        case .invalidCountryCode:
            return PhoneNumberInvalidCountryCodeError(countryCode: "")
        case .notANumber:
            return PhoneNumberNotANumberError(passedString: "")
        case .tooLong:
            return PhoneNumberTooLongError(number: "")
        case .tooShort:
            return PhoneNumberTooShortError(number: "")
        default:
            return PhoneNumberUnknownValidatingError(underlyingError: self)
        }
    }
}
