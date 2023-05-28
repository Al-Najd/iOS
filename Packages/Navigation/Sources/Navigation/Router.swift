//
//  Router.swift
//  CAFU
//
//  Created by Ahmed Allam on 12/09/2022.
//

import Content
import UIKit

// MARK: - AlertAction

public struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let action: () -> Void

    public init(
        title: String,
        style: UIAlertAction.Style,
        action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
}

public extension Sequence where Element == AlertAction {
    static var `default`: [AlertAction] { [
        AlertAction(title: L10n.generalOk, style: .default, action: { })
    ] }
}

// MARK: - Router

public protocol Router {
    var viewController: UIViewController? { get set }

    func alertWithAction(title: String?, message: String?, alertStyle: UIAlertController.Style, actions: [AlertAction])
}

public extension Router {
    func popToRoot(animated: Bool = true) {
        guard let navigation = viewController?.navigationController else {
            assertionFailure("No Navigation Controller found.")
            return
        }

        navigation.popToRootViewController(animated: animated)
    }

    func pop(animated: Bool = true) {
        guard let navigation = viewController?.navigationController else {
            assertionFailure("No Navigation Controller found.")
            return
        }

        navigation.popViewController(animated: animated)
    }

    func push(_ destination: UIViewController, animated: Bool) {
        guard let navigation = viewController?.navigationController else {
            assertionFailure("No Navigation Controller found.")
            return
        }

        navigation.pushViewController(destination, animated: animated)
    }
}

// MARK: - Alerts
public extension Router {
    func alertWithAction(
        title: String?,
        message: String?,
        alertStyle: UIAlertController.Style,
        actions: [AlertAction] = .default) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        actions.map { action in
            UIAlertAction(title: action.title, style: action.style, handler: { _ in
                action.action()
            })
        }.forEach {
            alert.addAction($0)
        }

        viewController?.present(alert, animated: true)
    }

    func genericAlert(action: @escaping () -> Void = { }) {
        alertWithAction(
            title: L10n.generalAlertTitle,
            message: nil,
            alertStyle: .actionSheet,
            actions: [
                .init(
                    title: L10n.generalOk,
                    style: .default,
                    action: action)
            ])
    }
}

public extension Router {
    func presentAsRoot(viewController: UIViewController) {
        AppRouter.shared.presentAsRoot(viewController: viewController)
    }
}
