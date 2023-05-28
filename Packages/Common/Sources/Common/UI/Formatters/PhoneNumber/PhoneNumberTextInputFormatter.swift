//
//  PhoneNumberTextInputFormatter.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import Factory
import Foundation
import Loggers
import PhoneNumberKit

// MARK: - PhoneNumberTextInputFormatter

class PhoneNumberTextInputFormatter: TextInputFormatter, TextFormatter, TextUnformatter {
    // MARK: - Dependencies

    private let caretPositionCorrector: CaretPositionCorrector
    private let rangeCalculator: RangeCalculator
    private let textFormatter: DefaultTextFormatter

    // MARK: - Properties

    private var textPattern: String { textFormatter.textPattern }
    private var patternSymbol: Character { textFormatter.patternSymbol }

    var countryCode: String?

    // MARK: - Life cycle
    /// Initializes formatter with patternString
    ///
    /// - Parameters:
    /// - textPattern: String with special characters, that will be used for formatting
    /// - patternSymbol: Optional parameter, that represent character, that will be replaced in formatted string
    /// - prefix: String, that always will be at beggining of text during editing
    public init(
        textPattern: String = Container.shared.authConfig().phoneNumberTextPattern,
        patternSymbol: Character = Container.shared.authConfig().phoneNumberTextPatternCharacter) {
        caretPositionCorrector = CaretPositionCorrector(
            textPattern: textPattern,
            patternSymbol: patternSymbol)
        textFormatter = DefaultTextFormatter(
            textPattern: textPattern,
            patternSymbol: patternSymbol)
        rangeCalculator = RangeCalculator()
    }

    // MARK: - TextInputFormatter

    open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
        guard let swiftRange = Range(range, in: currentText) else { return .empty }

        let text = text
            .replacingOccurrences(of: countryCode ?? "", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "—", with: "")
            .filter { "0123456789".contains($0) }

        let oldUnformattedText = unformat(currentText) ?? ""

        let unformattedCurrentTextRange = rangeCalculator.unformattedRange(
            currentText: currentText,
            textPattern: textPattern,
            from: swiftRange,
            patternSymbol: patternSymbol)
        let unformattedRange = oldUnformattedText.getSameRange(
            asIn: currentText,
            sourceRange: unformattedCurrentTextRange)

        let newText = oldUnformattedText.replacingCharacters(
            in: unformattedRange,
            with: text)

        let formattedText = format(newText) ?? ""
        let formattedTextRange = formattedText.getSameRange(
            asIn: currentText,
            sourceRange: swiftRange)

        let caretOffset = getCorrectedCaretPosition(
            newText: formattedText,
            range: formattedTextRange,
            replacementString: text)

        return FormattedTextValue(
            formattedText: formattedText,
            caretBeginOffset: caretOffset)
    }

    // MARK: - TextFormatter

    open func format(_ unformattedText: String?) -> String? {
        textFormatter.format(unformattedText)
    }

    // MARK: - TextUnformatter

    open func unformat(_ formatted: String?) -> String? {
        textFormatter.unformat(formatted)
    }

    // MARK: - Caret position calculation

    private func getCorrectedCaretPosition(newText: String, range: Range<String.Index>, replacementString: String) -> Int {
        caretPositionCorrector.calculateCaretPositionOffset(
            newText: newText,
            originalRange: range,
            replacementText: replacementString)
    }
}

// MARK: - PhoneNumber + Loggable

extension PhoneNumber: Loggable {
    public var debugDescription: String {
        display()
    }
}


public extension PhoneNumber {
    func display() -> String {
        PhoneNumberTextInputFormatter().format(number) ?? "\(countryCode)\(number)"
    }
}
