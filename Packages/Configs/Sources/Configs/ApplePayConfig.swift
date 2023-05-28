//
//  ApplePayConfig.swift
//  CAFU
//
//  Created by Ahmed Ramy on 30/01/2023.
//

import Foundation
import PassKit

// MARK: - ApplePayConfigurable

public protocol ApplePayConfigurable {
    var applePayCurrency: String { get }
    var applePayLocal: String { get }
    var paymentNetworks: [PKPaymentNetwork] { get }
    var countryCode: String { get }
}

// MARK: - ApplePayConfig

public struct ApplePayConfig: ApplePayConfigurable {
    public var applePayCurrency = "CAD"
    public var applePayLocal = "US"
    public var countryCode = "CA"
    public var paymentNetworks: [PKPaymentNetwork] = [
        .masterCard,
        .visa,
        .idCredit,
        .mada,
        .quicPay,
        .vPay,
        .amex,
        .chinaUnionPay,
        .discover,
        .eftpos,
        .electron,
        .elo,
        .interac,
        .JCB,
        .maestro,
        .privateLabel,
        .suica
    ]
}
