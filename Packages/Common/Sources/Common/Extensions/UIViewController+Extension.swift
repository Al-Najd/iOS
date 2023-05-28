//
//  UIViewcontroller+Extension.swift
//  CAFU
//
//  Created by Ahmed Allam on 16/09/2022.
//

import Configs
import UIKit

public extension UIViewController {
    func embededInsideNavigation() -> UINavigationController {
        .init(rootViewController: self)
    }

    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            T(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }

    func animate(
        duration: TimeInterval = UIConfig.default.animationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [.curveEaseInOut],
        animations: @escaping () -> Void,
        completion: ((UIViewAnimatingPosition) -> Void)? = nil) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: duration,
            delay: delay,
            options: options,
            animations: animations,
            completion: completion)
    }

    func transition(
        duration: TimeInterval = UIConfig.default.animationDuration,
        options: UIView.AnimationOptions = [.transitionCrossDissolve],
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil) {
        UIView.transition(
            with: view,
            duration: duration,
            options: options,
            animations: animations,
            completion: completion)
    }
}
