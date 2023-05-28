//
//  UINavigationController+Extension.swift
//  CAFU
//
//  Created by Ahmed Allam on 29/09/2022.
//

import UIKit

public extension UINavigationController {
    func update(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
