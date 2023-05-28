//
//  LoadingView.swift
//  CAFU
//
//  Created by Ahmed Allam on 09/01/2023.
//  Copyright © 2021 CAFU. All rights reserved.

import Foundation
import Lottie
import Navigation
import UIKit

// MARK: - LoadingViewProtocol

// sourcery: AutoMockable
public protocol LoadingViewProtocol {
    func show()
    func hide()
    func handleLoading(_ isLoading: Bool)
}

// MARK: - LoadingView

public class LoadingView: UIView, LoadingViewProtocol {
    var activityIndicator: AnimationComponentView?

    public init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .black.withAlphaComponent(0.3)
        clipsToBounds = true
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func handleLoading(_ isLoading: Bool) {
        isLoading ? show() : hide()
    }

    public func show() {
        addActivityIndicatorAsSubview()
        safeAsync {
            AppRouter.shared.window?.addSubview(self)
        }
    }

    public func hide() {
        safeAsync {
            self.activityIndicator?.stop()
            self.activityIndicator?.removeFromSuperview()
            self.activityIndicator = nil
            self.removeFromSuperview()
        }
    }

    private func addActivityIndicatorAsSubview() {
        safeAsync {
            if self.activityIndicator == nil {
                self.activityIndicator = AnimationComponentView()
            }

            self.activityIndicator?.play(using: Animation.loading)
            self.activityIndicator?.frame = CGRect(x: 0, y: 0, width: 40, height: 10)
            self.activityIndicator?.center = self.center
            self.activityIndicator?.clipsToBounds = true
            self.addSubview(self.activityIndicator!)
        }
    }
}
