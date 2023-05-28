//
//  Shadows+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/10/2022.
//

import UIKit

// MARK: - Shadow

// swiftlint:disable identifier_name

public struct Shadow {
    let color: UIColor
    let opacity: Float
    let x: CGFloat
    let y: CGFloat
    let blur: CGFloat
    let spread: CGFloat

    init(
        color: UIColor = .shadowMedium,
        opacity: Float = 0.14,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 14,
        spread: CGFloat = 0) {
        self.color = color
        self.opacity = opacity
        self.x = x
        self.y = y
        self.blur = blur
        self.spread = spread
    }
}

public extension Shadow {
    static let outterShadow: Shadow = .init()
    static let innerShadow: Shadow = .init(y: 1, blur: 3)
    static let none: Shadow = .init(color: .clear, opacity: 0, x: 0, y: 0, blur: 0, spread: 0)
}

public extension Shadow {
    static let shadowCherry: Shadow = .makeColoredShadow(.shadowCherry)
    static let shadowTangerine: Shadow = .makeColoredShadow(.shadowTangerine)
    static let shadowBlueperry: Shadow = .makeColoredShadow(.shadowBlueperry)

    private static func makeColoredShadow(_ color: UIColor) -> Shadow {
        .init(color: color, opacity: 1.0, x: 0, y: 0, blur: 7)
    }
}
