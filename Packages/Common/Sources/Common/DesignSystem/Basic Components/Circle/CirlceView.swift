//
//  CirlceView.swift
//  CAFU
//
//  Created by Ahmed Ramy on 09/02/2023.
//

import UIKit

class CircleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layerCornerRadius = max(frame.height, frame.width) / 2
    }
}
