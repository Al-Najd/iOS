//
//  Shadow.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 28/08/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import SwiftUI

// MARK: - ARShadow

public struct ARShadow {
    var color: Color
    var radius: CGFloat
    var position: CGPoint

    func offsetBy(x: CGFloat, y: CGFloat) -> ARShadow {
        ARShadow(
            color: color,
            radius: radius,
            position: .init(x: x, y: y))
    }

    func spreadBy(_ radius: CGFloat) -> ARShadow {
        ARShadow(
            color: color,
            radius: radius,
            position: position)
    }
}

public extension ARShadow {
    static let large = ThemeManager.shared.selectedTheme.largeShadow
    static let medium = ThemeManager.shared.selectedTheme.mediumShadow
    static let small = ThemeManager.shared.selectedTheme.smallShadow
}
