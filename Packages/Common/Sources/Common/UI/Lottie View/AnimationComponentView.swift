//
//  AnimationComponentView.swift
//  CAFU
//
//  Created by Ahmed Ramy on 03/10/2022.
//

import Factory
import Lottie
import UIKit

// MARK: - AnimationComponentView

@IBDesignable
public final class AnimationComponentView: NibDesignable {
    @IBOutlet private weak var animationView: LottieAnimationView?
    private var currentAnimation: Animation?

    override public var bundle: Bundle { .module }

    @Injected(\.lifecycle)
    private var lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public func play(using animation: Animation) {
        currentAnimation = animation
        configure(using: animation)
        animationView?.play()
    }

    public func stop() {
        currentAnimation = nil
        animationView?.stop()
    }
}

private extension AnimationComponentView {
    func handleLifecycleEvents() {
        lifecycle.appWillGoToForeground.uiSink { [weak self] in
            guard let self = self else { return }
            self.animationView?.play()
        }.store(in: &cancellables)

        lifecycle.appWillGoToBackground.uiSink { [weak self] in
            guard let self = self else { return }
            self.animationView?.pause()
        }.store(in: &cancellables)
    }

    func commonInit() {
        handleLifecycleEvents()
    }

    func configure(using animation: Animation) {
        animationView?.animation = animation == .none ? nil : LottieAnimation.named(animation.name)
        animationView?.contentMode = animation.contentMode
        animationView?.loopMode = animation.mode
    }
}
