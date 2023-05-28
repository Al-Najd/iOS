//
//  UIConfig.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import Factory
import Lottie
import UIKit.UIView

// MARK: - UIConfigurable

public protocol UIConfigurable {
    var animationDuration: CGFloat { get }
    var animationOptions: UIView.AnimationOptions { get }
    var transitionOptions: UIView.AnimationOptions { get }
    var loadingAnimation: Animation { get }
}

// MARK: - UIConfig

public struct UIConfig: UIConfigurable {
    public static let `default` = Container.shared.uiConfigs()
    public let animationDuration: CGFloat
    public let animationOptions: UIView.AnimationOptions
    public let transitionOptions: UIView.AnimationOptions
    public let loadingAnimation: Animation

    public init(
        animationDuration: CGFloat = 0.35,
        animationOptions: UIView.AnimationOptions = [.curveEaseInOut],
        transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve, .curveEaseInOut],
        loadingAnimation: Animation = .loading) {
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
        self.transitionOptions = transitionOptions
        self.loadingAnimation = loadingAnimation
    }
}
