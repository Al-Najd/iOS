//
//  UIFont+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import UIKit

public extension UIFont {
    static func alertRegular() -> UIFont {
        customFont("Poppins-Semibold", size: 17.0, textStyle: .headline)
    }

    static func headerExtraLarge() -> UIFont {
        customFont("Poppins-Bold", size: 36.0, textStyle: .largeTitle)
    }

    static func headerLarge() -> UIFont {
        customFont("Poppins-Bold", size: 24.0, textStyle: .title2)
    }

    static func headerMedium() -> UIFont {
        customFont("Poppins-Bold", size: 20.0, textStyle: .title3)
    }

    static func headerRegular() -> UIFont {
        customFont("Poppins-Bold", size: 16.0, textStyle: .headline)
    }

    static func headerSmall() -> UIFont {
        customFont("Poppins-Bold", size: 14.0, textStyle: .caption1)
    }

    static func headerExtraSmall() -> UIFont {
        customFont("Poppins-Bold", size: 12.0, textStyle: .footnote)
    }

    static func bodyExtraLarge() -> UIFont {
        customFont("Poppins-Regular", size: 24.0, textStyle: .title2)
    }

    static func bodyLarge() -> UIFont {
        customFont("Poppins-Regular", size: 18.0, textStyle: .headline)
    }

    static func bodyRegular() -> UIFont {
        customFont("Poppins-Regular", size: 14.0, textStyle: .caption1)
    }

    static func bodySmall() -> UIFont {
        customFont("Poppins-Regular", size: 12.0, textStyle: .footnote)
    }

    static func bodyXSmall() -> UIFont {
        customFont("Poppins-Regular", size: 10.0, textStyle: .footnote)
    }

    static func sfProRegular(size: Double) -> UIFont {
        customFont("Poppins-Regular", size: size, textStyle: .footnote)
    }
}

private extension UIFont {
    static func customFont(
        _ name: String,
        size: CGFloat,
        textStyle: UIFont.TextStyle? = nil,
        scaled: Bool = false)
        -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            assertionFailure("Fatal Error: Font \(name) not found.")
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }

        if scaled, let textStyle = textStyle {
            let metrics = UIFontMetrics(forTextStyle: textStyle)
            return metrics.scaledFont(for: font)
        } else {
            return font
        }
    }
}
