//
//  PhoneNumberTextDecorator.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import Foundation

// MARK: - PhoneNumberTextDecorator

struct PhoneNumberTextDecorator: TextDecorator {
    func decorate(_ number: String?) -> NSAttributedString? {
        guard let number = number else { return nil }
        return NSAttributedStringBuilder()
            .add(text: number)
            .add(foregroundColor: .greyLighter, for: "(")
            .add(foregroundColor: .greyLighter, for: ")")
            .add(foregroundColor: .greyLighter, for: "–")
            .build()
    }
}

// MARK: - PhoneNumberPlaceholderTextDecorator

struct PhoneNumberPlaceholderTextDecorator: TextDecorator {
    func decorate(_ number: String?) -> NSAttributedString? {
        guard let number = number else { return nil }
        return NSAttributedStringBuilder()
            .add(text: number)
            .add(foregroundColor: .greyMedium)
            .add(foregroundColor: .greyLighter, for: "(")
            .add(foregroundColor: .greyLighter, for: ")")
            .add(foregroundColor: .greyLighter, for: "–")
            .build()
    }
}
