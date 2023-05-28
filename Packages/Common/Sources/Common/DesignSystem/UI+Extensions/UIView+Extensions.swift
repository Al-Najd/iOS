//
//  UIView+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 04/10/2022.
//

import Configs
import Foundation
import UIKit

// swiftlint:disable identifier_name

public extension UIView {
    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable var layerBorderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }

    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable var layerBorderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    var parentViewController: UIViewController? {
        if let nextResponder = next as? UIViewController {
            return nextResponder
        } else if let nextResponder = next as? UIView {
            return nextResponder.parentViewController
        } else {
            return nil
        }
    }

    func animate(
        duration: TimeInterval = UIConfig.default.animationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = UIConfig.default.animationOptions,
        animations: @escaping () -> Void,
        completion: ((UIViewAnimatingPosition) -> Void)? = nil) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: duration,
            delay: delay,
            options: options,
            animations: animations,
            completion: completion)
    }

    func spring(
        duration: TimeInterval = UIConfig.default.animationDuration,
        delay: TimeInterval = 0,
        damping: CGFloat = 0.7,
        initialVelocity: CGFloat = 0.0,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil) {
        let springParameters = UISpringTimingParameters(
            mass: 1.0,
            stiffness: 260,
            damping: 20,
            initialVelocity: .init(dx: 0, dy: 1.0))

        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: springParameters)

        animator.addAnimations {
            animations()
        }

        animator.startAnimation(afterDelay: delay)
    }

    func transition(
        duration: TimeInterval = UIConfig.default.animationDuration,
        delay _: TimeInterval = 0,
        options: UIView.AnimationOptions = UIConfig.default.transitionOptions,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil) {
        UIView.transition(
            with: self,
            duration: duration,
            options: options,
            animations: animations,
            completion: completion)
    }

    func round(corners: CACornerMask, withRadius radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }

    func applyShadow(
        ofColor color: UIColor = .black,
        opacity: Float = 0.14,
        x: CGFloat = 0,
        y: CGFloat = 2,
        radius: CGFloat = 4,
        spread: CGFloat = 0) {
        layer.applyShadow(color: color, alpha: opacity, x: x, y: y, blur: radius, spread: spread)
    }

    func applyShadow(_ shadow: Shadow) {
        applyShadow(
            ofColor: shadow.color,
            opacity: shadow.opacity,
            x: shadow.x,
            y: shadow.y,
            radius: shadow.blur,
            spread: shadow.spread)
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return view
        }

        return UIView()
    }

    func convertViewToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.saveGState()
        layer.render(in: context)
        context.restoreGState()
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}

public extension UIView {
    /// SwifterSwift: Shake directions of a view.
    ///
    /// - horizontal: Shake left and right.
    /// - vertical: Shake up and down.
    enum ShakeDirection {
        /// SwifterSwift: Shake left and right.
        case horizontal

        /// SwifterSwift: Shake up and down.
        case vertical
    }

    /// SwifterSwift: Shake animations types.
    ///
    /// - linear: linear animation.
    /// - easeIn: easeIn animation.
    /// - easeOut: easeOut animation.
    /// - easeInOut: easeInOut animation.
    enum ShakeAnimationType {
        /// SwifterSwift: linear animation.
        case linear

        /// SwifterSwift: easeIn animation.
        case easeIn

        /// SwifterSwift: easeOut animation.
        case easeOut

        /// SwifterSwift: easeInOut animation.
        case easeInOut
    }

    /// SwifterSwift: Shake view.
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - animationType: shake animation type (default is .easeOut).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func shake(
        direction: ShakeDirection = .horizontal,
        duration: TimeInterval = 1,
        animationType: ShakeAnimationType = .easeOut,
        completion: (() -> Void)? = nil) {
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
}
