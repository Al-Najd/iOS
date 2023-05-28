//
//  CloseButton.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/10/2022.
//

import UIKit

@IBDesignable
public class CloseButton: NibDesignable {
    @IBOutlet private weak var outerShadowView: UIView!
    @IBOutlet private weak var innerShadowView: UIView!

    override public var bundle: Bundle { .module }

    public var onTap: (() -> Void)?

    @IBAction
    public func didTapClose() {
        onTap?()
    }
}
