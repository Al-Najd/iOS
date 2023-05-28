//
//  TextField+BorderSettings.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import UIKit.UIView

extension UIView {
    func configure(using border: TextField.BorderSettings) {
        layerBorderColor = border.color
        layerBorderWidth = border.width
        layerCornerRadius = border.cornerRadius
    }
}
