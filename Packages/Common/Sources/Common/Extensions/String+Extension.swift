//
//  String+Extension.swift
//  CAFU
//
//  Created by Ahmed Allam on 16/09/2022.
//

import UIKit

public extension String {
    var localized: String {
        NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
    }

    var isoDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self)
    }

    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }

    var emptyIfNil: String? {
        isEmpty ? nil : self
    }

    static let empty = ""
}

public extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        self?.isEmpty ?? true
    }
}
