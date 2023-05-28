//
//  AppRouter.swift
//  CAFU
//
//  Created by Ahmed Allam on 18/09/2022.
//

import Loggers
import UIKit

// MARK: - AppRouter

public class AppRouter {
    public static let shared = AppRouter()
    public var window: UIWindow?
    public var visibleViewController: UIViewController? { window?.visibleViewController }

    public func makeWindowVisible(from scene: UIScene, rootViewController: UIViewController) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }

    public func presentAsRoot(viewController: UIViewController) {
        guard let window = window else {
            Log.error("Failed to present \(viewController.description) as root")
            return
        }

        window.rootViewController = viewController
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.5
        UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: nil)
    }

    public func dismissVisibleVC(animated: Bool = true, completion: (() -> Void)? = nil) {
        visibleViewController?.dismiss(animated: animated, completion: completion)
    }
}
