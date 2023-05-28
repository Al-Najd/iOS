//
//  AccessibilityTests.swift
//
//
//  Created by Ahmed Ramy on 16/05/2023.
//

import XCTest
@testable import Common

// MARK: - AccessibilityTests

final class AccessibilityTests: XCTestCase {
    func testAccessibleClassesAreAbleToAutoGenerateTheirIdentifiersForUITesting() {
        let view = AccessibleViewController()

        view.generateAccessibilityIdentifiers()

        XCTAssertEqual("ViewController.descriptionLabel", view.descriptionLabel.accessibilityIdentifier)
        XCTAssertEqual("ViewController.actionButton", view.actionButton.accessibilityIdentifier)
        XCTAssertEqual("ViewController.phoneTextField", view.phoneTextField.accessibilityIdentifier)
        XCTAssertEqual("ViewController.emailTextField", view.emailTextField.accessibilityIdentifier)
    }
}

// MARK: AccessibilityTests.AccessibleViewController

extension AccessibilityTests {
    class AccessibleViewController: UIViewController {
        let descriptionLabel = UILabel()
        let actionButton = UIButton()
        let phoneTextField = UITextField()
        let emailTextField = UITextField()
    }
}

// MARK: - AccessibilityTests.AccessibleViewController + Accessible

extension AccessibilityTests.AccessibleViewController: Accessible { }
