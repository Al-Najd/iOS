//
//  FormattersTests.swift
//
//
//  Created by Ahmed Ramy on 13/04/2023.
//

import XCTest
@testable import Common

final class FormattersTests: XCTestCase {
    func testParsingCountryCodeString() throws {
        // Given
        let formatter = CountryCodeFormatter()
        let testString = "🇦🇪 +971"

        // When
        let actualCountryCode = try formatter.parse(testString).get()

        // Then
        XCTAssertEqual(actualCountryCode.flagEmoji, "🇦🇪")
        XCTAssertEqual(actualCountryCode.code, "971")
    }
}
