//
//  UILabel+Extension.swift
//  CAFU
//
//  Created by Ahmed Allam on 18/11/2022.
//

import UIKit

public extension UILabel {
    func highlightText(_ searchText: String) {
        guard
            let labelText = text,
            !labelText.isEmpty,
            let regex = try? NSRegularExpression(pattern: searchText, options: .caseInsensitive)
        else {
            return
        }

        let attributedString = NSMutableAttributedString(string: labelText)
        let boldFont = UIFont.headerSmall()
        let boldColor = UIColor.greyPrimaryGrey

        regex
            .matches(
                in: labelText,
                options: .withTransparentBounds,
                range: NSRange(location: 0, length: labelText.utf16.count))
            .forEach {
                attributedString.addAttributes([.font: boldFont, .foregroundColor: boldColor], range: $0.range)
            }

        attributedText = attributedString
    }
}
