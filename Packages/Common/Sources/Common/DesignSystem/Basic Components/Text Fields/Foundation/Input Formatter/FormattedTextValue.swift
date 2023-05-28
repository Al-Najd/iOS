//
//  FormattedTextValue.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import Foundation

public struct FormattedTextValue: Equatable {
    public let formattedText: String
    public let caretBeginOffset: Int

    public init(formattedText: String, caretBeginOffset: Int) {
        self.formattedText = formattedText
        self.caretBeginOffset = caretBeginOffset
    }

    public static var empty: FormattedTextValue {
        FormattedTextValue(formattedText: "", caretBeginOffset: 0)
    }
}
