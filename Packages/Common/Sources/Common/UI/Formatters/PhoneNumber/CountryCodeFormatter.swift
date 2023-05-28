//
//  File.swift
//
//
//  Created by Ahmed Ramy on 13/04/2023.
//

import Configs
import Factory
import Foundation
import Loggers

// MARK: - CountryCodeFormatter

public struct CountryCodeFormatter {
    @Injected(\.authConfig)
    var authConfig
    public init() { }

    public func format(_ code: CountryCode) -> String {
        "\(code.flagEmoji)  \(code.code)"
    }

    public func parse(_ input: String?) -> Result<CountryCode, FormattingError> {
        guard !input.isEmptyOrNil, let input = input else { return .failure(.invalidInput) }
        guard let emoji = extractEmoji(input) else { return .failure(.invalidCountryEmoji.whileLogging()) }

        let code = input.filter { "123456789".contains(String($0)) }
        guard !code.isEmpty else { return .failure(.invalidCountryCode.whileLogging()) }

        return .success(CountryCode(code: code, flagEmoji: emoji))
    }

    private func extractEmoji(_ input: String) -> String? {
        guard let emojiCharacter = input.first(where: { authConfig.availableCountriesEmojis.contains(String($0)) })
        else { return nil }
        return String(emojiCharacter)
    }
}

// MARK: CountryCodeFormatter.FormattingError

public extension CountryCodeFormatter {
    enum FormattingError: Error, LoggableWithContext {
        case invalidCountryCode
        case invalidCountryEmoji
        case invalidInput

        public var context: String { "Country Code Formatting" }

        public var debugDescription: String {
            switch self {
            case .invalidCountryCode:
                return "Unknown country code was trying to be formatted..."
            case .invalidCountryEmoji:
                return "Unknown country emoji was given to be parsed"
            case .invalidInput:
                return "Input was nil or empty"
            }
        }
    }
}
