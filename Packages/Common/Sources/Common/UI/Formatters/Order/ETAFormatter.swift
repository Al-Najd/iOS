//
//  ETAFormatter.swift
//  CAFU
//
//  Created by Ahmed Ramy on 04/11/2022.
//

import Foundation
import Localization

class ETAFormatter: RelativeDateTimeFormatter {
    override init() {
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        locale = LocalizationService.shared.currentLanguage.locale
        unitsStyle = .full
        dateTimeStyle = .numeric
        formattingContext = .middleOfSentence
    }
}
