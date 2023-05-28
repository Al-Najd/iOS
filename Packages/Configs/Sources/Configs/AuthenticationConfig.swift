//
//  AuthenticationConfig.swift
//  CAFU
//
//  Created by Ahmed Ramy on 30/01/2023.
//

import Foundation

// MARK: - AuthenticationConfigurable

public protocol AuthenticationConfigurable {
    var countryCode: String { get }
    var phoneNumberTextPattern: String { get }
    var phoneNumberTextPatternCharacter: Character { get }
    var otpCodeLenght: Int { get }
    var validationDebounceDuration: Double { get }
    var countryCodeFlag: String { get }
    var availableCountriesEmojis: [String] { get }
}

// MARK: - AuthenticationConfig

public struct AuthenticationConfig: AuthenticationConfigurable {
    public let countryCode = "+1"
    public let countryCodeFlag = "🇨🇦"
    public let phoneNumberTextPattern = "(###) ### – ####"
    public let phoneNumberTextPatternCharacter: Character = "#"
    public let otpCodeLenght = 4
    public let validationDebounceDuration = 1.5
    public let availableCountriesEmojis = ["🇨🇦", "🇦🇪"]
}
