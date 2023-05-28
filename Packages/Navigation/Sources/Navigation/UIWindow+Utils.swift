//
//  File.swift
//
//
//  Created by Ahmed Ramy on 31/03/2023.
//

import UIKit

public extension UIWindow {
    static var current: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        var window: UIWindow?
        if #available(iOS 15.0, *) {
            window = windowScene.keyWindow
        } else {
            window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        }

        return window
    }

    var visibleViewController: UIViewController? {
        UIWindow.getVisibleViewControllerFrom(rootViewController)
    }

    static func getVisibleViewControllerFrom(_ viewController: UIViewController?) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(navigationController.visibleViewController)
        } else if let tabbarController = viewController as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tabbarController.selectedViewController)
        } else {
            if let presentedViewController = viewController?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(presentedViewController)
            } else {
                return viewController
            }
        }
    }
}
