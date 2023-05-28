//
//  TextFormatter.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import Foundation

// MARK: - TextFormatter

/// Interface of text formatter
public protocol TextFormatter {
    /// Formatting text with current textPattern
    ///
    /// - Parameters:
    ///  - unformatted: String to convert
    ///
    /// - Returns: Formatted text
    func format(_ unformattedText: String?) -> String?
}

// MARK: - TextUnformatter

public protocol TextUnformatter {
    /// Method for convert string, that sutisfy current textPattern, into unformatted string
    ///
    /// - Parameters:
    ///  - formatted: String to convert
    ///
    /// - Returns: String converted into unformatted
    func unformat(_ formattedText: String?) -> String?
}
