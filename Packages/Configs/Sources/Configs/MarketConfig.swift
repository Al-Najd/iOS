//
//  MarketConfig.swift
//  CAFU
//
//  Created by Ahmed Ramy on 21/09/2022.
//

import Foundation

// MARK: - MarketConfigurable

// TODO: - [EVC-1094] Change Data type of URLs to be 'URL' instead of 'String'
public protocol MarketConfigurable {
    var currency: String { get }
    var locale: String { get }
    var customerSupportPhoneNumber: String { get }
    var privacyPolicyURL: String { get }
    var termsURL: String { get }
}

// MARK: - MarketConfig

public struct MarketConfig: MarketConfigurable {
    public let currency: String
    public let locale: String
    public let customerSupportPhoneNumber: String
    public let privacyPolicyURL: String
    public let termsURL: String

    public init(
        currency: String = "$",
        locale: String = "en_US",
        customerSupportPhoneNumber: String = "+17785572393",
        privacyPolicyURL: String = "https://www.cafu.com/privacy",
        termsURL: String = "https://www.cafu.com/terms") {
        self.currency = currency
        self.locale = locale
        self.customerSupportPhoneNumber = customerSupportPhoneNumber
        self.privacyPolicyURL = privacyPolicyURL
        self.termsURL = termsURL
    }

    public mutating func updating(
        currency: String? = nil,
        locale: String? = nil,
        customerSupportPhoneNumber: String? = nil,
        privacyPolicyURL: String? = nil,
        termsURL: String? = nil) {
        self = .init(
            currency: currency ?? self.currency,
            locale: locale ?? self.locale,
            customerSupportPhoneNumber: customerSupportPhoneNumber ?? self.customerSupportPhoneNumber,
            privacyPolicyURL: privacyPolicyURL ?? self.privacyPolicyURL,
            termsURL: termsURL ?? self.termsURL)
    }
}
