//
//  HapticButton.swift
//  CAFU
//
//  Created by Ahmed Allam on 04/10/2022.
//

import UIKit

public final class HapticButton: UIButton {
    @IBOutlet var outletViewToBeScaled: UIView?
    lazy var viewToBeScaled: UIView = outletViewToBeScaled ?? self

    init(viewToBeScaled: UIView, frame: CGRect) {
        super.init(frame: frame)
        self.viewToBeScaled = viewToBeScaled
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        pressed()
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        released()
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        cancelled()
    }

    @objc
    private func pressed() {
        guard isEnabled else { return }
        UIView.animate(withDuration: 0.08) {
            self.viewToBeScaled.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }

    @objc
    private func released() {
        guard isEnabled else { return }
        UIView.animate(withDuration: 0.1) {
            self.viewToBeScaled.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }

    @objc
    private func cancelled() {
        guard isEnabled else { return }
        UIView.animate(withDuration: 0.1) {
            self.viewToBeScaled.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
