//
//  AccessibilityTests.swift
//
//
//  Created by Ahmed Ramy on 16/05/2023.
//

import XCTest
@testable import Common

final class AccessibilityTests: XCTestCase {
    func testGivenLabelWasCreated_WhenPassingSomeTextToIt_AccessibilityIdentifierIsAutomaticallyUpdated() {
        // Given
        let label = Label()

        // When
        label.text = "I am UI Automatable"

        // Then
        XCTAssertEqual(label.accessibilityIdentifier, label.text)
    }
}
