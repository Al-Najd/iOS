//
//  UserNameFormatter.swift
//  CAFU
//
//  Created by Adithi Bolar on 17/11/2022.
//

import Foundation
import Localization

class UserNameFormatter: PersonNameComponentsFormatter {
    override init() {
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        if #available(iOS 15.0, *) {
            locale = LocalizationService.shared.currentLanguage.locale
        }
        style = .abbreviated
    }
}
