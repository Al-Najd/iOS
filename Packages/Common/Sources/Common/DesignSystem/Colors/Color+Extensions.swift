//
//  Color+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 07/10/2022.
//

import SwiftUI

public extension Color {
    static let greenDark = Color("Green/Dark", bundle: .module)
    static let greenLight = Color("Green/Light", bundle: .module)
    static let greenLighter = Color("Green/Lighter", bundle: .module)
    static let greenMedium = Color("Green/Medium", bundle: .module)
    static let greenPrimaryGreen = Color("Green/Primary Green", bundle: .module)
    static let greenSuperlight = Color("Green/Superlight", bundle: .module)
    static let greySuperlight = Color("Grey/Superlight", bundle: .module)
    static let greyDark = Color("Grey/Dark", bundle: .module)
    static let greyLight = Color("Grey/Light", bundle: .module)
    static let greyLighter = Color("Grey/Lighter", bundle: .module)
    static let greyMedium = Color("Grey/Medium", bundle: .module)
    static let greyPrimaryGrey = Color("Grey/Primary Grey", bundle: .module)
    static let greyRegular = Color("Grey/Regular", bundle: .module)
    static let greyWhite = Color("Grey/White", bundle: .module)
    static let redDark = Color("Red/Dark", bundle: .module)
    static let redLight = Color("Red/Light", bundle: .module)
    static let redLighter = Color("Red/Lighter", bundle: .module)
    static let redMedium = Color("Red/Medium", bundle: .module)
    static let redPrimaryRed = Color("Red/Primary Red", bundle: .module)
    static let redSuperlight = Color("Red/Superlight", bundle: .module)
    static let tealDark = Color("Teal/Dark", bundle: .module)
    static let tealLight = Color("Teal/Light", bundle: .module)
    static let tealLighter = Color("Teal/Lighter", bundle: .module)
    static let tealMedium = Color("Teal/Medium", bundle: .module)
    static let tealPrimaryTeal = Color("Teal/Primary Teal", bundle: .module)
    static let tealSuperlight = Color("Teal/Superlight", bundle: .module)
    static let yellowDark = Color("Yellow/Dark", bundle: .module)
    static let yellowLight = Color("Yellow/Light", bundle: .module)
    static let yellowMedium = Color("Yellow/Medium", bundle: .module)
    static let yellowPrimaryYellow = Color("Yellow/Primary Yellow", bundle: .module)
    static let yellowSuperDark = Color("Yellow/Super Dark", bundle: .module)
    static let yellowSuperlight = Color("Yellow/Superlight", bundle: .module)
    static let shadowMedium = Color("Shadow / Medium", bundle: .module)
    static let shadowBlueperry = Color("Shadow /Bluberry", bundle: .module)
    static let shadowCherry = Color("Shadow /Cherry", bundle: .module)
    static let shadowTangerine = Color("Shadow /Tangerine", bundle: .module)
    static let outliersBorder = Color("Home/Border", bundle: .module)

    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff

        self.init(red: CGFloat(red) / 0xff, green: CGFloat(green) / 0xff, blue: CGFloat(blue) / 0xff)
    }
}
