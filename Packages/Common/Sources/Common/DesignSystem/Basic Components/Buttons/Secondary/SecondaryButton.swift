//
//  SecondaryButton.swift
//  CAFU
//
//  Created by Ahmed Ramy on 30/09/2022.
//

import UIKit

// MARK: - SecondaryButton

@IBDesignable
class SecondaryButton: Button {
    override func updateUISettings() {
        let uiSettings = getSuitableUISettings()
        animate { [weak self] in
            guard let self = self else { return }
            self.outerShadowView.configure(using: uiSettings.outerShadow)
            self.innerShadowView.configure(using: uiSettings.innerShadow)
            self.contentView.configure(using: uiSettings.cornerRadius)
            self.isUserInteractionEnabled = uiSettings.isEnabled
            self.contentView.backgroundColor = uiSettings.backgroundColor
            self.titleLabel.textColor = uiSettings.textColor
        }
    }
}

private extension SecondaryButton {
    func getSuitableUISettings() -> UISettings {
        switch state {
        case .enabled:
            return .secondaryEnabled
        case .disabled:
            return .disabled
        }
    }
}

extension Button.UISettings {
    static let secondaryEnabled: Button.UISettings = .init(
        innerShadow: .innerShadow,
        outerShadow: .outerShadow,
        isEnabled: true,
        textColor: .greyPrimaryGrey,
        backgroundColor: .greyWhite,
        cornerRadius: .rounded)
}

private extension SecondaryButton {
    func commonInit() {
        updateUISettings()
    }
}
