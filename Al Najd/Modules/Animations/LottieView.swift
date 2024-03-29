//
//  LottieView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/01/2022.
//

import Lottie
import SwiftUI

// MARK: - LottieView

public struct LottieView: UIViewRepresentable {
    var animation: OAnimation
    var loopMode: LottieLoopMode
    var contentMode: UIView.ContentMode

    /// Acts like callbacks at certain time in case some handling needs to be made during a certain time
    let animationFramesHandlers: [AnimationHandler]

    public init(
        animation: OAnimation,
        loopMode: LottieLoopMode = .loop,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        animationFramesHandlers: [AnimationHandler] = []) {
        self.animation = animation
        self.loopMode = loopMode
        self.contentMode = contentMode
        self.animationFramesHandlers = animationFramesHandlers
    }

    public func makeUIView(context _: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()

        animationView.animation = LottieAnimation.named(animation.name)
        animationView.contentMode = contentMode
        startPlaying(animationView, handlers: animationFramesHandlers)
        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])

        return view
    }

    public func updateUIView(_: UIView, context _: UIViewRepresentableContext<LottieView>) { }

    private func startPlaying(_ animationView: LottieAnimationView, handlers: [AnimationHandler]) {
        guard !handlers.isEmpty else { return }
        let handler = handlers[0]
        animationView.play(
            fromFrame: handler.startFrame,
            toFrame: handler.endFrame,
            loopMode: .playOnce) { didFinish in
                handler.onComplete(didFinish)
                startPlaying(animationView, handlers: Array(handlers.dropFirst()))
            }
    }
}

// MARK: - OAnimation

public struct OAnimation {
    let name: String

    public init(name: String) {
        self.name = name
    }
}

// MARK: - AnimationHandler

public struct AnimationHandler {
    let startFrame: CGFloat
    let endFrame: CGFloat
    let onComplete: LottieCompletionBlock

    public init(startFrame: CGFloat, endFrame: CGFloat, onComplete: @escaping LottieCompletionBlock) {
        self.startFrame = startFrame
        self.endFrame = endFrame
        self.onComplete = onComplete
    }
}
