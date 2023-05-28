//
//  Money.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 17/10/2022.
//

import Configs
import Factory
import Foundation
import Loggers

// MARK: - Money

struct Money {
    var value: Double
    var currency: String = Container.shared.marketConfig().currency

    func display(moneyFormater: MoneyFormater = MoneyFormater()) -> String {
        moneyFormater.string(from: NSNumber(value: value)) ?? "\(currency)\(value)"
    }

    init(value: Int, currency: String = Container.shared.marketConfig().currency) {
        self.value = Double(value)
        self.currency = currency
    }

    init(value: Double, currency: String = Container.shared.marketConfig().currency) {
        self.value = value
        self.currency = currency
    }
}

extension Double {
    func asMoney(currency: String = Container.shared.marketConfig().currency) -> Money {
        .init(value: self, currency: currency)
    }

    func asMoney(currency: String? = nil) -> Money {
        .init(value: self, currency: currency ?? Container.shared.marketConfig().currency)
    }
}

extension Int {
    func asMoney(currency: String = Container.shared.marketConfig().currency) -> Money {
        .init(value: self, currency: currency)
    }

    func asMoney(currency: String? = nil) -> Money {
        .init(value: self, currency: currency ?? Container.shared.marketConfig().currency)
    }
}

extension Money {
    static let zero = Money(value: 0)
}

// MARK: - Money + Loggable

extension Money: Loggable {
    var debugDescription: String {
        display()
    }
}
