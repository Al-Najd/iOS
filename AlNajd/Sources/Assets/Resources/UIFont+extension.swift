//  swiftlint:disable all
//
//  The code generated using FigmaExport — Command line utility to export
//  colors, typography, icons and images from Figma to Xcode project.
//
//  https://github.com/RedMadRobot/figma-export
//
//  Don’t edit this code manually to avoid runtime crashes
//

import UIKit

public extension UIFont {

    static func bodyExtraLarge() -> UIFont {
        customFont("RobotoRoman-Regular", size: 24.0)
    }

    static func bodyExtraLargeBold() -> UIFont {
        customFont("RobotoRoman-Bold", size: 24.0)
    }

    static func bodyExtraSmallBold() -> UIFont {
        customFont("RobotoRoman-Bold", size: 10.0)
    }

    static func bodyLargeBold() -> UIFont {
        customFont("RobotoRoman-Bold", size: 18.0)
    }

    static func bodyRegularBold() -> UIFont {
        customFont("RobotoRoman-Bold", size: 14.0)
    }

    static func bodySmallBold() -> UIFont {
        customFont("RobotoRoman-Bold", size: 12.0)
    }

    static func bodyExtraSmall() -> UIFont {
        customFont("RobotoRoman-Regular", size: 10.0)
    }

    static func bodyLarge() -> UIFont {
        customFont("RobotoRoman-Regular", size: 16.0)
    }

    static func bodyRegular() -> UIFont {
        customFont("RobotoRoman-Regular", size: 14.0)
    }

    static func bodySmall() -> UIFont {
        customFont("RobotoRoman-Regular", size: 12.0)
    }

    static func buttonsLarge() -> UIFont {
        customFont("RobotoRoman-Medium", size: 16.0)
    }

    static func buttonsRegular() -> UIFont {
        customFont("RobotoRoman-Medium", size: 14.0)
    }

    static func headersLarge() -> UIFont {
        customFont("RobotoRoman-Bold", size: 24.0)
    }

    static func headersSmall() -> UIFont {
        customFont("RobotoRoman-Bold", size: 14.0)
    }

    static func headersSubheadline() -> UIFont {
        customFont("RobotoRoman-Bold", size: 20.0)
    }

    static func headersExtraLarge() -> UIFont {
        customFont("RobotoRoman-Bold", size: 36.0)
    }

    static func headersRegular() -> UIFont {
        customFont("RobotoRoman-Bold", size: 16.0)
    }

    static func iosHeaderExtraLarge() -> UIFont {
        customFont("SFPro-Bold", size: 36.0)
    }

    static func iosHeaderLarge() -> UIFont {
        customFont("SFPro-Bold", size: 24.0)
    }

    static func iosHeaderMedium() -> UIFont {
        customFont("SFPro-Bold", size: 20.0)
    }

    static func iosHeaderRegular() -> UIFont {
        customFont("SFPro-Bold", size: 16.0)
    }

    static func iosHeaderSmall() -> UIFont {
        customFont("SFPro-Bold", size: 14.0)
    }

    static func iosBodyExtraLarge() -> UIFont {
        customFont("SFPro-Regular", size: 24.0)
    }

    static func iosBodyLarge() -> UIFont {
        customFont("SFPro-Regular", size: 18.0)
    }

    static func iosBodyRegular() -> UIFont {
        customFont("SFPro-Regular", size: 14.0)
    }

    static func iosBodySmall() -> UIFont {
        customFont("SFPro-Regular", size: 12.0)
    }

    private static func customFont(
        _ name: String,
        size: CGFloat,
        textStyle: UIFont.TextStyle? = nil,
        scaled: Bool = false) -> UIFont {

        guard let font = UIFont(name: name, size: size) else {
            print("Warning: Font \(name) not found.")
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
