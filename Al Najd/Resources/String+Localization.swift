//
//  File.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import Foundation

public extension String {
    /// SwifterSwift: Returns a localized string, with an optional comment for translators.
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    var localized: String {
        NSLocalizedString(self, tableName: "Localizables", bundle: .localizationBundle, comment: "")
    }

    func localized(arguments: CVarArg...) -> String {
        String(format: localized, arguments: arguments.map { "\($0)" })
    }
}

extension Foundation.Bundle {
    static var localizationBundle: Bundle = .main
}
