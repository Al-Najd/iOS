//
//  Palettes.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 28/08/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import SwiftUI

public struct PrimaryPalette: BrandColor {
    public var `default`: Color
    public var dark: Color
    public var darkMode: Color
    public var light: Color
    public var background: Color

    public init(_ bundle: Bundle = .main) {
        self.default = .init("Primary.default", bundle: bundle)
        dark = .init("Primary.dark", bundle: bundle)
        darkMode = .init("Primary.darkMode", bundle: bundle)
        light = .init("Primary.light", bundle: bundle)
        background = .init("Primary.background", bundle: bundle)
    }
}

public struct SecondaryPalette: BrandColor {
    public var `default`: Color
    public var dark: Color
    public var darkMode: Color
    public var light: Color
    public var background: Color

    public init(_ bundle: Bundle = .main) {
        self.default = .init("Secondary.default", bundle: bundle)
        dark = .init("Secondary.dark", bundle: bundle)
        darkMode = .init("Secondary.darkMode", bundle: bundle)
        light = .init("Secondary.light", bundle: bundle)
        background = .init("Secondary.background", bundle: bundle)
    }
}

public struct SuccessPalette: BrandColor {
    public var `default`: Color
    public var dark: Color
    public var darkMode: Color
    public var light: Color
    public var background: Color

    public init(_ bundle: Bundle = .main) {
        self.default = .init("Success.default", bundle: bundle)
        dark = .init("Success.dark", bundle: bundle)
        darkMode = .init("Success.darkMode", bundle: bundle)
        light = .init("Success.light", bundle: bundle)
        background = .init("Success.background", bundle: bundle)
    }
}

public struct WarningPalette: BrandColor {
    public var `default`: Color
    public var dark: Color
    public var darkMode: Color
    public var light: Color
    public var background: Color

    public init(_ bundle: Bundle = .main) {
        self.default = .init("Warning.default", bundle: bundle)
        dark = .init("Warning.dark", bundle: bundle)
        darkMode = .init("Warning.darkMode", bundle: bundle)
        light = .init("Warning.light", bundle: bundle)
        background = .init("Warning.background", bundle: bundle)
    }
}

public struct DangerPalette: BrandColor {
    public var `default`: Color
    public var dark: Color
    public var darkMode: Color
    public var light: Color
    public var background: Color

    public init(_ bundle: Bundle = .main) {
        self.default = .init("Danger.default", bundle: bundle)
        dark = .init("Danger.dark", bundle: bundle)
        darkMode = .init("Danger.darkMode", bundle: bundle)
        light = .init("Danger.light", bundle: bundle)
        background = .init("Danger.background", bundle: bundle)
    }
}

public struct InfoPalette: BrandColor {
    public var `default`: Color
    public var dark: Color
    public var darkMode: Color
    public var light: Color
    public var background: Color

    public init(_ bundle: Bundle = .main) {
        self.default = .init("Info.default", bundle: bundle)
        dark = .init("Info.dark", bundle: bundle)
        darkMode = .init("Info.darkMode", bundle: bundle)
        light = .init("Info.light", bundle: bundle)
        background = .init("Info.background", bundle: bundle)
    }
}

public struct TransparencyPalette: Transparency {
    public var light: Color = .init("Transparency.light.full")
    public var dark: Color = .init("Transparency.dark.full")

    public func light(by percentage: CGFloat) -> Color {
        light
            .opacity(Double(percentage) / 100)
    }

    public func dark(by percentage: CGFloat) -> Color {
        dark
            .opacity(Double(percentage) / 100)
    }
}

public struct MonochromaticPalette: MonochromaticColor {
    public var offblack: Color
    public var ash: Color
    public var body: Color
    public var label: Color
    public var placeholder: Color
    public var line: Color
    public var input: Color
    public var background: Color
    public var offwhite: Color

    init(_ bundle: Bundle = .main) {
        offblack = .init("Monochromatic.offblack", bundle: bundle)
        ash = .init("Monochromatic.offblack", bundle: bundle)
        body = .init("Monochromatic.body", bundle: bundle)
        label = .init("Monochromatic.label", bundle: bundle)
        placeholder = .init("Monochromatic.placeholder", bundle: bundle)
        line = .init("Monochromatic.line", bundle: bundle)
        input = .init("Monochromatic.input", bundle: bundle)
        background = .init("Monochromatic.background", bundle: bundle)
        offwhite = .init("Monochromatic.offwhite", bundle: bundle)
    }
}

class CurrentBundleFinder {}

extension Foundation.Bundle {
    static var designSystemBundle: Bundle = {
        /* The name of your local package, prepended by "LocalPackages_" */
        let bundleName = "OrdiCore_DesignSystem"
        let candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,
            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            /* For command-line tools. */
            Bundle.main.bundleURL,
            /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
}

public extension UIColor {
    convenience init(_ hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

public extension Color {
    init(_ hexString: String) {
        self.init(UIColor(hexString))
    }
}
