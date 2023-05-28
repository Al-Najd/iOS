//
//  DashedBorderView.swift
//  CAFU
//
//  Created by Ahmed Allam on 29/11/2022.
//

import UIKit

public class DashedBorderView: UIView {
    @IBInspectable public private(set) var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable public private(set) var dashWidth: CGFloat = 0
    @IBInspectable public private(set) var dashColor: UIColor = .clear
    @IBInspectable public private(set) var dashLength: CGFloat = 0
    @IBInspectable public private(set) var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?

    override public func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
