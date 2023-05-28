//
//  Keyboard+BottomConstraint.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import UIKit

public class KeyboardLayoutConstraint: NSLayoutConstraint {
    private var offset: CGFloat = 0
    private var keyboardVisibleHeight: CGFloat = 0 { didSet { updateConstant() }}

    override public func awakeFromNib() {
        super.awakeFromNib()

        offset = constant

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardLayoutConstraint.keyboardWillShowNotification(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardLayoutConstraint.keyboardWillHideNotification(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Notification

    @objc
    func keyboardWillShowNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard
            let height = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
                .cgRectValue
                .size
                .height
        else { return }

        keyboardVisibleHeight = height
        updateWindow(userInfo: userInfo)
    }

    @objc
    func keyboardWillHideNotification(_ notification: NSNotification) {
        keyboardVisibleHeight = 0
        guard let userInfo = notification.userInfo else { return }
        updateWindow(userInfo: userInfo)
    }

    func updateConstant() {
        constant = offset + keyboardVisibleHeight
    }

    private func updateWindow(userInfo: [AnyHashable: Any]) {
        switch (
            userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
            userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber) {
        case (.some(let duration), .some(let curve)):

            let options = UIView.AnimationOptions(rawValue: curve.uintValue)

            UIView.animate(
                withDuration: TimeInterval(duration.doubleValue),
                delay: 0,
                options: options,
                animations: {
                    UIWindow.current?.layoutIfNeeded()
                })
        default:

            break
        }
    }
}
