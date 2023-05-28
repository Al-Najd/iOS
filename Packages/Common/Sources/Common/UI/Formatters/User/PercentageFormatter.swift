//
//  PercentageFormatter.swift
//  CAFU
//
//  Created by Ahmed Ramy on 03/10/2022.
//

import Foundation
import Localization

class PercentageFormatter: NumberFormatter {
    private let isPrecise: Bool

    init(isPrecise: Bool = false) {
        self.isPrecise = isPrecise
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        isPrecise = false
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        locale = LocalizationService.shared.currentLanguage.locale
        numberStyle = .percent
        maximumFractionDigits = isPrecise ? 3 : 0
    }
}
