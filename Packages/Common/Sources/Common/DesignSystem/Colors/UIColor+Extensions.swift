//
//  UIColor+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import UIKit.UIColor

public extension UIColor {
    static let greenDark = UIColor(named: "Green/Dark", in: .module, compatibleWith: nil)!
    static let greenLight = UIColor(named: "Green/Light", in: .module, compatibleWith: nil)!
    static let greenLighter = UIColor(named: "Green/Lighter", in: .module, compatibleWith: nil)!
    static let greenMedium = UIColor(named: "Green/Medium", in: .module, compatibleWith: nil)!
    static let greenPrimaryGreen = UIColor(named: "Green/Primary Green", in: .module, compatibleWith: nil)!
    static let greenSuperlight = UIColor(named: "Green/Superlight", in: .module, compatibleWith: nil)!
    static let greySuperlight = UIColor(named: "Grey/Superlight", in: .module, compatibleWith: nil)!
    static let greyDark = UIColor(named: "Grey/Dark", in: .module, compatibleWith: nil)!
    static let greyLight = UIColor(named: "Grey/Light", in: .module, compatibleWith: nil)!
    static let greyLighter = UIColor(named: "Grey/Lighter", in: .module, compatibleWith: nil)!
    static let greyMedium = UIColor(named: "Grey/Medium", in: .module, compatibleWith: nil)!
    static let greyPrimaryGrey = UIColor(named: "Grey/Primary Grey", in: .module, compatibleWith: nil)!
    static let greyRegular = UIColor(named: "Grey/Regular", in: .module, compatibleWith: nil)!
    static let greyWhite = UIColor(named: "Grey/White", in: .module, compatibleWith: nil)!
    static let redDark = UIColor(named: "Red/Dark", in: .module, compatibleWith: nil)!
    static let redLight = UIColor(named: "Red/Light", in: .module, compatibleWith: nil)!
    static let redLighter = UIColor(named: "Red/Lighter", in: .module, compatibleWith: nil)!
    static let redMedium = UIColor(named: "Red/Medium", in: .module, compatibleWith: nil)!
    static let redPrimaryRed = UIColor(named: "Red/Primary Red", in: .module, compatibleWith: nil)!
    static let redSuperlight = UIColor(named: "Red/Superlight", in: .module, compatibleWith: nil)!
    static let tealDark = UIColor(named: "Teal/Dark", in: .module, compatibleWith: nil)!
    static let tealLight = UIColor(named: "Teal/Light", in: .module, compatibleWith: nil)!
    static let tealLighter = UIColor(named: "Teal/Lighter", in: .module, compatibleWith: nil)!
    static let tealMedium = UIColor(named: "Teal/Medium", in: .module, compatibleWith: nil)!
    static let tealPrimaryTeal = UIColor(named: "Teal/Primary Teal", in: .module, compatibleWith: nil)!
    static let tealSuperlight = UIColor(named: "Teal/Superlight", in: .module, compatibleWith: nil)!
    static let yellowDark = UIColor(named: "Yellow/Dark", in: .module, compatibleWith: nil)!
    static let yellowLight = UIColor(named: "Yellow/Light", in: .module, compatibleWith: nil)!
    static let yellowMedium = UIColor(named: "Yellow/Medium", in: .module, compatibleWith: nil)!
    static let yellowPrimaryYellow = UIColor(named: "Yellow/Primary Yellow", in: .module, compatibleWith: nil)!
    static let yellowSuperDark = UIColor(named: "Yellow/Super Dark", in: .module, compatibleWith: nil)!
    static let yellowSuperlight = UIColor(named: "Yellow/Superlight", in: .module, compatibleWith: nil)!
    static let shadowMedium = UIColor(named: "Shadow / Medium", in: .module, compatibleWith: nil)!
    static let shadowBlueperry = UIColor(named: "Shadow /Bluberry", in: .module, compatibleWith: nil)!
    static let shadowCherry = UIColor(named: "Shadow /Cherry", in: .module, compatibleWith: nil)!
    static let shadowTangerine = UIColor(named: "Shadow /Tangerine", in: .module, compatibleWith: nil)!
    static let lowChargeBackground = UIColor(named: "Home/lowChargeBackground", in: .module, compatibleWith: nil)!
    static let midChargeBackground = UIColor(named: "Home/midChargeBackground", in: .module, compatibleWith: nil)!
    static let highChargeBackground = UIColor(named: "Home/highChargeBackground", in: .module, compatibleWith: nil)!
    static let outliersBorder = UIColor(named: "Home/Border", in: .module, compatibleWith: nil)!

    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff

        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1.0)
    }
}
