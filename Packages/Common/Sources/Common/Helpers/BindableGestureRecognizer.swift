//
//  BindableGestureRecognizer.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import UIKit

// MARK: - BindableGestureRecognizer

public final class BindableGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(execute))
    }

    @objc
    private func execute() {
        action()
    }
}

public extension UIView {
    func onTapping(times: Int = 1, do action: @escaping () -> Void) {
        let tap = BindableGestureRecognizer(action: action)
        tap.numberOfTapsRequired = times
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}
