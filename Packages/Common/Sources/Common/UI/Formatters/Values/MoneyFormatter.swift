//
//  MoneyFormatter.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 17/10/2022.
//

import Configs
import Factory
import Foundation
import Localization

public final class MoneyFormater: NumberFormatter {
    @Injected(\.marketConfig)
    private var configs

    override public init() {
        super.init()
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        locale = LocalizationService.shared.currentLanguage.locale
        numberStyle = .currency
        maximumFractionDigits = 2
        currencyCode = configs.currency
        locale = Locale(identifier: configs.locale)
    }
}
