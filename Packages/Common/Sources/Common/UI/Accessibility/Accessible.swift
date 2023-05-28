//
//  File.swift
//
//
//  Created by Ahmed Ramy on 19/05/2023.
//

import Foundation
import UIKit

// MARK: - Accessible

public protocol Accessible {
    /// Generates Accessibility Identifiers to look similar to this 'ViewController.descriptionLabel'
    ///
    /// - Note: Utilizes Mirror(Reflecting: T) API to fetch the name used for the label
    /// - Warning: Doesn't work in production builds
    func generateAccessibilityIdentifiers()
}

public extension Accessible {
    func generateAccessibilityIdentifiers() {
        #if !RELEASE
        let mirror = Mirror(reflecting: self)

        for child in mirror.children {
            if
                let view = child.value as? UIView,
                let identifier = child.label?.replacingOccurrences(of: ".storage", with: "") {
                view.accessibilityIdentifier = "\(type(of: self)).\(identifier)"
            }
        }
        #endif
    }
}
