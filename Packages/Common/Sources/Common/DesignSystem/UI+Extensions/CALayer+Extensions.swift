//
//  CALayer+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 04/10/2022.
//

import Foundation
import UIKit

// swiftlint:disable identifier_name

public extension CACornerMask {
    static var topLeading: CACornerMask { .layerMinXMinYCorner }
    static var topTrailing: CACornerMask { .layerMaxXMinYCorner }
    static var bottomLeading: CACornerMask { .layerMinXMaxYCorner }
    static var bottomTrailing: CACornerMask { .layerMaxXMaxYCorner }

    static var top: CACornerMask { [.topLeading, .topTrailing] }
    static var bottom: CACornerMask { [.bottomLeading, .bottomTrailing] }
    static var leading: CACornerMask { [.topLeading, .bottomLeading] }
    static var trailing: CACornerMask { [.topTrailing, .bottomTrailing] }
}

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.14,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
