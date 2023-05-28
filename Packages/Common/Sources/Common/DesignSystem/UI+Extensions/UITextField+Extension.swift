//
//  UITextField+Extension.swift
//  CAFU
//
//  Created by Ahmed Ramy on 21/09/2022.
//

import UIKit

extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
}
