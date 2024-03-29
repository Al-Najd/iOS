//
//  Fontable.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 01/06/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//
#if os(macOS)
import AppKit
#else
import UIKit
#endif
import FontBlaster
import SwiftUI

#if os(macOS)
public typealias MPFont = NSFont
public typealias MPColor = NSColor
public typealias MPTextContentType = NSTextContentType
public typealias MPViewRepresentable = NSViewRepresentable
public typealias MPTextField = NSTextField
public typealias MPScreen = NSText
#else
public typealias MPFont = UIFont
public typealias MPColor = UIColor
public typealias MPTextField = UITextField
public typealias MPTextContentType = UITextContentType
public typealias MPViewRepresentable = UIViewRepresentable
public typealias MPTextAutocapitalizationType = UITextAutocorrectionType
public typealias MPKeyboardType = UITextAutocapitalizationType
public typealias MPReturnKeyType = UIKeyboardType
public typealias MPTextInputPasswordRules = UIReturnKeyType
public typealias MPTextSmartDashesType = UITextInputPasswordRules
public typealias MPTextSmartInsertDeleteType = UITextSmartDashesType
public typealias MPTextSmartQuotesType = UITextSmartInsertDeleteType
public typealias MPTextSpellCheckingType = UITextSmartQuotesType
public typealias MPTextAutocorrectionType = UITextSpellCheckingType
#endif

// MARK: - FontType

public enum FontType: String, Codable {
    case sansSerif
    case serif

    init(string: String) {
        switch string {
        case "sans-serif":
            self = .sansSerif
        case "serif":
            self = .serif
        default:
            self = .sansSerif
        }
    }
}

// MARK: - FontCategory

public enum FontCategory: String, Codable {
    /// Big Titles and large pieces of texts
    /// Font Sizes: 34 - 20
    case display
    /// Moderate Text
    /// Font Sizes: 20 - 13
    case text
    /// Small texts like captions and links
    /// Font Sizes: 20 - 13
    case link
}

// MARK: - FontScale

public enum FontScale: String, Codable {
    /// Display -> 34
    /// Text -> 20
    /// Link -> 20
    case huge
    /// Display -> 28
    /// Text -> 20
    /// Link -> 20
    case large
    /// Display -> 24
    /// Text -> 17
    /// Link -> 17
    case medium
    /// Display -> 20
    /// Text -> 15
    /// Link -> 15
    case small
    /// Display -> 20
    /// Text -> 13
    /// Link -> 13
    case xsmall
}

// MARK: - FontWeight

public enum FontWeight: String, Codable {
    case regular
    case bold

    func toSwiftUIFontWeight() -> Font.Weight {
        switch self {
        case .regular:
            return .regular
        case .bold:
            return .bold
        }
    }
}

// MARK: - FontLocale

public enum FontLocale: String, Codable {
    case english
    case arabic

    public init(language: Language) {
        switch language {
        case .english:
            self = .english
        case .arabic:
            self = .arabic
        }
    }

    public init(string: String) {
        switch string {
        case "arabic":
            self = .arabic
        case "english":
            self = .english
        default:
            self = .english
        }
    }

    public func toLanguage() -> Language {
        switch self {
        case .english:
            return .english
        case .arabic:
            return .arabic
        }
    }
}

// MARK: - FontProtocol

public protocol FontProtocol: Codable {
    var fontDetails: FontDetails { get set }
    var fontCategory: FontCategory { get set }
    var fontScale: FontScale { get set }
    var fontWeight: FontWeight { get set }
    var font: MPFont { get }
    var metrics: FontMetrics { get }
}

public extension FontProtocol {
    var metrics: FontMetrics {
        switch fontCategory {
        case .display:
            switch fontScale {
            case .huge:
                return .init(size: 34, lineHeight: 48, letterSpacing: 1)
            case .large:
                return .init(size: 28, lineHeight: 40, letterSpacing: 1)
            case .medium:
                return .init(size: 24, lineHeight: 34, letterSpacing: 1)
            case .small,
                 .xsmall:
                return .init(size: 20, lineHeight: 32, letterSpacing: 1)
            }
        case .text:
            switch fontScale {
            case .huge,
                 .large:
                return .init(size: 20, lineHeight: 32, letterSpacing: 0.75)
            case .medium:
                return .init(size: 17, lineHeight: 28, letterSpacing: 0.75)
            case .small:
                return .init(size: 15, lineHeight: 24, letterSpacing: 0.75)
            case .xsmall:
                return .init(size: 13, lineHeight: 22, letterSpacing: 0.25)
            }
        case .link:
            switch fontScale {
            case .huge,
                 .large:
                return .init(size: 20, lineHeight: 32, letterSpacing: 0.75)
            case .medium:
                return .init(size: 17, lineHeight: 28, letterSpacing: 0.75)
            case .small:
                return .init(size: 15, lineHeight: 24, letterSpacing: 0.75)
            case .xsmall:
                return .init(size: 13, lineHeight: 22, letterSpacing: 0.25)
            }
        }
    }

    var font: MPFont {
        MPFont(name: fontName, size: metrics.size) ?? .systemFont(ofSize: metrics.size)
    }

    var fontName: String {
        "\(fontDetails.name)-\(mapWeight(weight: fontWeight))"
    }

    private func mapWeight(weight: FontWeight) -> String {
        switch weight {
        case .bold:
            return "Bold"
        case .regular:
            return "Regular"
        }
    }
}

// MARK: - FontMetricsProtocol

public protocol FontMetricsProtocol {
    var size: CGFloat { get }
    var lineHeight: CGFloat { get }
    var letterSpacing: CGFloat { get }
}

// MARK: - FontMetrics

public struct FontMetrics: Codable, FontMetricsProtocol {
    public let size: CGFloat
    public let lineHeight: CGFloat
    public let letterSpacing: CGFloat
}

// MARK: - FontDetails

public struct FontDetails: Codable {
    public var name: String
    public var fontLocale: FontLocale
    public var fontType: FontType

    public init(name: String, fontLocale: FontLocale, fontType: FontType) {
        self.name = name
        self.fontLocale = fontLocale
        self.fontType = fontType
    }
}

// MARK: - ARFont

public struct ARFont: FontProtocol {
    public var fontDetails: FontDetails
    public var fontCategory: FontCategory
    public var fontScale: FontScale
    public var fontWeight: FontWeight

    public init(fontDetails: FontDetails, fontCategory: FontCategory, fontScale: FontScale, fontWeight: FontWeight) {
        self.fontDetails = fontDetails
        self.fontCategory = fontCategory
        self.fontScale = fontScale
        self.fontWeight = fontWeight
    }

    public init(_ fontCategory: FontCategory, _ fontScale: FontScale, _ fontWeight: FontWeight) {
        self = FontManager.shared.getSuitableFont(category: fontCategory, scale: fontScale, weight: fontWeight)
    }
}

public extension ARFont {
    /// Display Huge Bold 34
    static let pLargeTitle: ARFont = FontManager.shared.getSuitableFont(category: .display, scale: .huge, weight: .regular)
    /// Display Large Bold 28
    static let pTitle1: ARFont = FontManager.shared.getSuitableFont(category: .display, scale: .large, weight: .regular)
    /// Display Medium Bold 24
    static let pTitle2: ARFont = FontManager.shared.getSuitableFont(category: .display, scale: .medium, weight: .regular)
    /// Display Small Bold 20
    static let pTitle3: ARFont = FontManager.shared.getSuitableFont(category: .display, scale: .small, weight: .regular)
    /// Text 'Medium Size' 'Regular Weight' 17
    static let pHeadline: ARFont = FontManager.shared.getSuitableFont(category: .text, scale: .medium, weight: .regular)
    /// Link Small Regular 15
    static let pSubheadline: ARFont = FontManager.shared.getSuitableFont(category: .link, scale: .small, weight: .regular)
    /// Text Small Regular 15
    static let pBody: ARFont = FontManager.shared.getSuitableFont(category: .text, scale: .small, weight: .regular)
    /// Text XSmall Regular 13
    static let pFootnote: ARFont = FontManager.shared.getSuitableFont(category: .text, scale: .xsmall, weight: .regular)
}

public extension ARFont {
    /// Bold 34
    static let displayHuge: ARFont = FontManager.shared.getSuitableFont(category: .display, scale: .huge, weight: .regular)
    /// Bold 28
    static let displayLarge: ARFont = FontManager.shared.getSuitableFont(category: .display, scale: .large, weight: .regular)
    /// Bold 24
    static let displayMedium: ARFont = FontManager.shared.getSuitableFont(category: .display, scale: .medium, weight: .regular)
    /// Bold 20
    static let displaySmall: ARFont = FontManager.shared.getSuitableFont(category: .display, scale: .small, weight: .regular)
    /// Regular 17
    static let textMedium: ARFont = FontManager.shared.getSuitableFont(category: .text, scale: .medium, weight: .regular)
    /// Regular 15
    static let linkSmall: ARFont = FontManager.shared.getSuitableFont(category: .link, scale: .small, weight: .regular)
    /// Regular 15
    static let textSmall: ARFont = FontManager.shared.getSuitableFont(category: .text, scale: .small, weight: .regular)
    /// Regular 13
    static let textXSmall: ARFont = FontManager.shared.getSuitableFont(category: .text, scale: .xsmall, weight: .regular)
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
public extension View {
    func scaledFont(_ font: ARFont, _ weight: Font.Weight = .regular) -> some View {
        modifier(
            ScaledFont(name: font.fontName, size: font.metrics.size, weight: weight))
    }

    func scaledFont(
        locale: FontLocale,
        _ font: ARFont,
        _ weight: Font.Weight = .regular)
        -> some View {
        let extractedExpr: ScaledFont = { (font: ARFont) -> ScaledFont in
            ScaledFont(name: font.fontName, size: font.metrics.size, weight: weight)
        }(
            FontManager.shared.getFont(
                locale: locale,
                type: font.fontDetails.fontType,
                category: font.fontCategory,
                scale: font.fontScale,
                weight: font.fontWeight))
        return modifier(
            extractedExpr)
    }
}

// MARK: - ScaledFont

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size).adaptRatio()
        return content.font(.custom(name, size: scaledSize).weight(weight))
    }
}

// MARK: - SizeAdaptableFont

public protocol SizeAdaptableFont {
    /// Scaled per Size font for FontStyle.
    var sizeAdaptableFont: MPFont { get }
}

// MARK: - ARFont + SizeAdaptableFont

extension ARFont: SizeAdaptableFont {
    public var sizeAdaptableFont: MPFont {
        MPFont(
            name: fontName,
            size: adapt(metrics.size)) ?? .systemFont(
            ofSize: adapt(metrics.size))
    }

    private func adapt(_ size: CGFloat) -> CGFloat {
        switch UIScreen.main.bounds.height {
        case 1000...: // iPad
            return size * 2
        default:
            return size
        }
    }
}

// MARK: - AccessibilityFont

public protocol AccessibilityFont {
    /// Dynamically scalled font for FontStyle.
    var accessibleFont: MPFont { get }
}

// MARK: - ARFont + AccessibilityFont

extension ARFont: AccessibilityFont {
    private func getMappedTextStyle() -> MPFont.TextStyle {
        switch (fontCategory, fontScale, fontWeight) {
        case (.display, .huge, _):
            return .largeTitle
        case (.display, .large, _):
            return .title1
        case (.display, .medium, _):
            return .title2
        case (.display, .small, _),
             (.display, .xsmall, _),
             (.text, .huge, _),
             (.link, .huge, _),
             (.text, .large, _),
             (.link, .large, _):
            return .title3
        case (.text, .medium, .bold),
             (.link, .medium, .bold):
            return .headline
        case (.text, .medium, .regular),
             (.link, .medium, .regular):
            return .body
        case (.text, .small, _):
            return .subheadline
        case (.text, .xsmall, _):
            return .footnote
        case (.link, .small, _):
            return .subheadline
        case (.link, .xsmall, _):
            return .footnote
        }
    }

    func makeAccessible(font: UIFont) -> MPFont {
        UIFontMetrics(forTextStyle: getMappedTextStyle()).scaledFont(for: font)
    }

    public var accessibleFont: MPFont {
        #if os(macOS)
        font
        #else
        UIFontMetrics(forTextStyle: getMappedTextStyle()).scaledFont(for: font)
        #endif
    }

    public var accessibleLineHeight: CGFloat {
        #if os(macOS)
        metrics.lineHeight
        #else
        UIFontMetrics(forTextStyle: getMappedTextStyle()).scaledValue(for: metrics.lineHeight)
        #endif
    }

    public var accessibleLetterSpacing: CGFloat {
        #if os(macOS)
        metrics.letterSpacing
        #else
        UIFontMetrics(forTextStyle: getMappedTextStyle()).scaledValue(for: metrics.letterSpacing)
        #endif
    }
}

private extension MPFont {
    func addDeviceSizeAdaption() -> MPFont {
        guard FontManager.shared.supportsDeviceSizeAdaption else { return self }
        let size = pointSize.adaptV(min: pointSize * 0.75, max: pointSize * 2) * CGFloat(FontManager.shared.fontMultiplier)
        return MPFont(
            name: fontName,
            size: size) ?? .systemFont(ofSize: size)
    }
}

// MARK: - Language

public enum Language: CaseIterable {
    case arabic
    case english

    public var languageCode: String {
        switch self {
        case .arabic: return "ar"
        case .english: return "en"
        }
    }

    public init(_ language: String) {
        switch language {
        case "ar": self = .arabic
        case "en": self = .english
        default: self = .english
        }
    }

    public init(localeLanguageCode: String) {
        switch localeLanguageCode {
        case "ar": self = .arabic
        case "en": self = .english
        default: self = .english
        }
    }

    public var isRTLLanguage: Bool {
        self == .arabic
    }
}
