//
//  File.swift
//
//
//  Created by Ahmed Ramy on 13/04/2023.
//

import Foundation

public struct CountryCode {
    public let code: String
    public let flagEmoji: String

    public init(code: String, flagEmoji: String) {
        self.code = code.replacingOccurrences(of: "+", with: "")
        self.flagEmoji = flagEmoji
    }

    public func display(_ formatter: CountryCodeFormatter = .init()) -> String {
        formatter.format(self)
    }
}
