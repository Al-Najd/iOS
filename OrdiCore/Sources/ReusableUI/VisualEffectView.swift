//
//  VisualEffectView.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 28/08/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import SwiftUI
import UIKit

public struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    public init(_ style: UIBlurEffect.Style) {
        self.style = style
    }

    public func makeUIView(context _: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    public func updateUIView(_: UIView,
                             context _: UIViewRepresentableContext<BlurView>) {}
}
