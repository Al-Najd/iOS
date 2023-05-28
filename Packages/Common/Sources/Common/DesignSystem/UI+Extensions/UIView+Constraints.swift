//
//  UIView+Constraints.swift
//  CAFU
//
//  Created by Ahmed Allam on 23/01/2023.
//

import UIKit

public extension UIView {
    func centerInSuperview() {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func centerYConstraintInSuperview(multiplier: CGFloat = 1.0, constant: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: self,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: superview,
            attribute: .centerY,
            multiplier: multiplier,
            constant: constant).isActive = true
    }

    func equalSuperviewWidth(multiplier: CGFloat = 1.0, constant: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: superview,
            attribute: .width,
            multiplier: multiplier,
            constant: constant).isActive = true
    }

    func leading(constant: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        return leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant)
    }

    func trailing(constant: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant).isActive = true
    }

    func top(constant: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
    }

    func bottom(constant: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant).isActive = true
    }

    func constraintWidth(equalToConstant constant: CGFloat) {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func constraintHeight(equalToConstant constant: CGFloat) {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func aspectRatio(_ ratio: CGFloat) {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio).isActive = true
    }

    func equalSuperviewHeight(multiplier: CGFloat = 1.0, constant: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: superview,
            attribute: .height,
            multiplier: multiplier,
            constant: constant).isActive = true
    }

    func centerXConstraintInSuperview(multiplier: CGFloat = 1.0, constant: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: self,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: superview,
            attribute: .centerX,
            multiplier: multiplier,
            constant: constant).isActive = true
    }

    func sizeConstraint(equalTo size: CGSize) {
        guard superview != nil else { return }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func fillInSuperview(constant: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: constant),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func fillInSuperviewConstraints(constant: CGFloat = 0) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("Superview is nil")
        }
        translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant),
        ]
        return constraints
    }

    func fillInViewConstraints(_ superview: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = [
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func addSubViewWithConstraints(
        subView: UIView,
        top: CGFloat = 0,
        bottom: CGFloat = 0,
        left: CGFloat = 0,
        right: CGFloat = 0) {
        addSubview(subView)

        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
        subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom).isActive = true
        subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: left).isActive = true
        subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: right).isActive = true
    }
}
