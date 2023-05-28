//
//  Button.swift
//  CAFU
//
//  Created by Ahmed Ramy on 27/09/2022.
//

import Foundation
import UIKit

// MARK: - ButtonComponent

// swiftlint:disable identifier_name

public protocol ButtonComponent {
    var state: Button.State { get set }
    var text: String? { get set }
    var onTap: (() -> Void)? { get set }

    func updateUISettings()
}

// MARK: - LoadableButton

public protocol LoadableButton {
    func startLoading()
    func stopLoading()
}

// MARK: - Button

@IBDesignable
open class Button: NibDesignable, ButtonComponent {
    @IBOutlet public private(set) weak var outerShadowView: ShadowView!
    @IBOutlet public private(set) weak var innerShadowView: ShadowView!
    @IBOutlet public private(set) weak var contentView: UIView!
    @IBOutlet public private(set) weak var contentStackView: UIStackView!
    @IBOutlet public private(set) weak var titleLabel: UILabel!
    @IBOutlet public private(set) weak var leftImageView: UIImageView!
    @IBOutlet public private(set) weak var rightImageView: UIImageView!
    @IBOutlet public private(set) weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet public private(set) weak var actionButton: HapticButton!

    override public var bundle: Bundle { .module }

    public var state: Button.State = .enabled {
        didSet {
            updateUISettings()
            updateBehaviorSettings()
        }
    }

    @IBInspectable
    public var text: String? {
        get { titleLabel.text }
        set {
            titleLabel.text = newValue
            accessibilityIdentifier = newValue
        }
    }

    @IBInspectable
    public var leftImage: UIImage? {
        get { leftImageView.image }
        set { leftImageView.image = newValue }
    }

    @IBInspectable
    public var rightImage: UIImage? {
        get { rightImageView.image }
        set { rightImageView.image = newValue }
    }

    public var onTap: (() -> Void)?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open func updateUISettings() {
        let uiSettings = getSuitableUISettings()
        animate { [weak self] in
            guard let self = self else { return }
            self.outerShadowView.configure(using: uiSettings.outerShadow)
            self.innerShadowView.configure(using: uiSettings.innerShadow)
            self.contentView.configure(using: uiSettings.cornerRadius)
            self.contentView.backgroundColor = uiSettings.backgroundColor
            self.titleLabel.textColor = uiSettings.textColor
            self.isUserInteractionEnabled = uiSettings.isEnabled
        }
    }

    public func updateBehaviorSettings() {
        actionButton.isEnabled = state == .enabled
    }

    @IBAction
    func buttonDidPressed(_: UIButton) {
        onTap?()
    }
}

// MARK: Button.State

public extension Button {
    enum State {
        case enabled
        case disabled
    }
}

// MARK: - CornerRadius

public enum CornerRadius {
    case none
    case specific(CGFloat)
    case rounded
}

private extension Button {
    func commonInit() {
        titleLabel.text = text
        actionButton.viewToBeScaled = self
        updateUISettings()
    }

    func getSuitableUISettings() -> UISettings {
        switch state {
        case .enabled:
            return .enabled
        case .disabled:
            return .disabled
        }
    }
}

// MARK: - Button + LoadableButton

extension Button: LoadableButton {
    public func startLoading() {
        animate { [weak self] in
            guard let self = self else { return }
            self.contentStackView.subviews.forEach { $0.alpha = 0 }
            self.contentView.backgroundColor = .tealDark
            self.isUserInteractionEnabled = false
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.contentStackView.subviews.forEach { $0.isHidden = true }
            self.activityIndicator.isHidden = false
            self.isUserInteractionEnabled = true
            self.animate { [weak self] in
                guard let self = self else { return }
                self.activityIndicator.alpha = 1
            }
        }
    }

    public func stopLoading() {
        transition { [weak self] in
            guard let self = self else { return }
            self.contentStackView.subviews.forEach { $0.alpha = 0 }
            self.isUserInteractionEnabled = true
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.contentStackView.subviews.forEach { $0.isHidden = false }
            self.activityIndicator.isHidden = true
            self.isUserInteractionEnabled = true
            self.animate { [weak self] in
                guard let self = self else { return }
                self.contentStackView.subviews.forEach { $0.alpha = 1 }
                self.contentView.backgroundColor = self.getSuitableUISettings().backgroundColor
            }
        }
    }
}

public extension UIView {
    func configure(using shadow: Button.ShadowSettings) {
        applyShadow(
            ofColor: shadow.color,
            opacity: Float(shadow.opacity),
            x: shadow.x,
            y: shadow.y,
            radius: shadow.radius,
            spread: shadow.spread)
    }
}

public extension UIView {
    func configure(using cornerRadius: CornerRadius) {
        switch cornerRadius {
        case .rounded:
            layerCornerRadius = min(frame.height, frame.width) / 2
        case .specific(let radius):
            layerCornerRadius = radius
        case .none:
            break
        }
    }
}

public extension Button {
    struct UISettings {
        public let innerShadow: ShadowSettings
        public let outerShadow: ShadowSettings
        public let isEnabled: Bool
        public let textColor: UIColor
        public let backgroundColor: UIColor
        public let cornerRadius: CornerRadius

        public init(
            innerShadow: ShadowSettings,
            outerShadow: ShadowSettings,
            isEnabled: Bool,
            textColor: UIColor,
            backgroundColor: UIColor,
            cornerRadius: CornerRadius = .specific(16)) {
            self.innerShadow = innerShadow
            self.outerShadow = outerShadow
            self.isEnabled = isEnabled
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
        }
    }

    struct ShadowSettings {
        public let color: UIColor
        public let x: CGFloat
        public let y: CGFloat
        public let radius: CGFloat
        public let opacity: CGFloat
        public let spread: CGFloat

        public init(color: UIColor, x: CGFloat = 0, y: CGFloat, radius: CGFloat, opacity: CGFloat = 0.14, spread: CGFloat = 0) {
            self.color = color
            self.x = x
            self.y = y
            self.radius = radius
            self.opacity = opacity
            self.spread = spread
        }
    }
}

public extension Button.UISettings {
    static let enabled: Button.UISettings = .init(
        innerShadow: .innerShadow,
        outerShadow: .outerShadow,
        isEnabled: true,
        textColor: .greyWhite,
        backgroundColor: .tealPrimaryTeal)

    static let disabled: Button.UISettings = .init(
        innerShadow: .none,
        outerShadow: .none,
        isEnabled: false,
        textColor: .greyLighter,
        backgroundColor: .greyLight)
}

public extension Button.ShadowSettings {
    static let none: Button.ShadowSettings = .init(color: .clear, x: 0, y: 0, radius: 0, opacity: 0)
    static let innerShadow: Button.ShadowSettings = .init(color: .shadowMedium, x: 0, y: 1, radius: 14, opacity: 0.14)
    static let outerShadow: Button.ShadowSettings = .init(color: .shadowMedium, x: 0, y: 1, radius: 3, opacity: 0.14)
}
