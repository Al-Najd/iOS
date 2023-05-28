//
//  UIStackView+Extension.swift
//  CAFU
//
//  Created by Ahmed Allam on 20/10/2022.
//

import UIKit

public extension UIStackView {
    func show(_ views: UIView...) {
        make(viewsVisible: views)
    }

    func hide(_ views: UIView...) {
        make(viewsHidden: views)
    }

    private func make(viewsHidden: [UIView] = [], viewsVisible: [UIView] = [], animated: Bool = true) {
        let viewsHidden = viewsHidden.filter { $0.superview === self }
        let viewsVisible = viewsVisible.filter { $0.superview === self }

        let blockToSetVisibility: ([UIView], _ hidden: Bool) -> Void = { views, hidden in
            views.forEach { $0.isHidden = hidden }
        }

        // need for smooth animation
        let blockToSetAlphaForSubviewsOf: ([UIView], _ alpha: CGFloat) -> Void = { views, alpha in
            views.forEach { view in
                view.subviews.forEach { $0.alpha = alpha }
            }
        }

        if !animated {
            blockToSetVisibility(viewsHidden, true)
            blockToSetVisibility(viewsVisible, false)
            blockToSetAlphaForSubviewsOf(viewsHidden, 1)
            blockToSetAlphaForSubviewsOf(viewsVisible, 1)
        } else {
            // update hidden values of all views
            // without that animation doesn't go
            let allViews = viewsHidden + viewsVisible
            layer.removeAllAnimations()
            allViews.forEach { view in
                let oldHiddenValue = view.isHidden
                view.layer.removeAllAnimations()
                view.layer.isHidden = oldHiddenValue
            }

            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    blockToSetAlphaForSubviewsOf(viewsVisible, 1)
                    blockToSetAlphaForSubviewsOf(viewsHidden, 0)

                    blockToSetVisibility(viewsHidden, true)
                    blockToSetVisibility(viewsVisible, false)
                    self.layoutIfNeeded()
                },
                completion: nil)
        }
    }
}
