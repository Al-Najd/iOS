//
//  ViewConstraints.swift
//  CAFU
//
//  Created by Ahmed Allam on 13/02/2022.
//  Copyright © 2022. All rights reserved.
//

import UIKit

// MARK: - ViewConstraints

protocol ViewConstraints where Self: UITraitEnvironment {
    func sharedConstraints() -> [NSLayoutConstraint]
    func compactConstraints() -> [NSLayoutConstraint]
    func regularConstraints() -> [NSLayoutConstraint]

    func setupConstraints()
}

extension ViewConstraints {
    func compactConstraints() -> [NSLayoutConstraint] { [] }

    func regularConstraints() -> [NSLayoutConstraint] { [] }

    func setupConstraints() {
        let sharedConstraints = sharedConstraints()
        let compactConstraints = compactConstraints()
        let regularConstraints = regularConstraints()

        setupTrailtCollectionConstraints(shared: sharedConstraints, compact: compactConstraints, regular: regularConstraints)
    }

    private func setupTrailtCollectionConstraints(
        shared: [NSLayoutConstraint],
        compact: [NSLayoutConstraint],
        regular: [NSLayoutConstraint]) {
        if shared.count > 0, !shared[0].isActive {
            // activating shared constraints
            NSLayoutConstraint.activate(shared)
        }

        if traitCollection.horizontalSizeClass == .compact, traitCollection.verticalSizeClass == .regular {
            if regular.count > 0, regular[0].isActive {
                NSLayoutConstraint.deactivate(regular)
            }
            // activating compact constraints
            NSLayoutConstraint.activate(compact)
        } else {
            if compact.count > 0, compact[0].isActive {
                NSLayoutConstraint.deactivate(compact)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regular)
        }
    }
}
