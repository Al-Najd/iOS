//
//  Label.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import UIKit

// MARK: - Label

@IBDesignable
public class Label: UILabel {
    var style: LabelStyle? { nil }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            updateText()
        }
    }

    public convenience init(text: String?, textColor: UIColor) {
        self.init()
        self.text = text
        self.textColor = textColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        updateText()
    }

    private func commonInit() {
        font = style?.font
        adjustsFontForContentSizeCategory = true
        isAccessibilityElement = true
    }

    private func updateText() {
        text = super.text
    }

    override public var text: String? {
        get {
            guard style?.attributes != nil else {
                return super.text
            }

            return attributedText?.string
        }
        set {
            accessibilityIdentifier = newValue
            guard let style = style else {
                super.text = newValue
                return
            }

            guard let newText = newValue else {
                attributedText = nil
                super.text = nil
                return
            }

            attributedText = style.attributedString(from: newText, alignment: textAlignment, lineBreakMode: lineBreakMode)
        }
    }
}

// MARK: - HeaderExtraLargeLabel

public final class HeaderExtraLargeLabel: Label {
    override var style: LabelStyle? {
        .headerExtraLarge()
    }
}

// MARK: - HeaderLargeLabel

public final class HeaderLargeLabel: Label {
    override var style: LabelStyle? {
        .headerLarge()
    }
}

// MARK: - HeaderMediumLabel

public final class HeaderMediumLabel: Label {
    override var style: LabelStyle? {
        .headerMedium()
    }
}

// MARK: - HeaderRegularLabel

public final class HeaderRegularLabel: Label {
    override var style: LabelStyle? {
        .headerRegular()
    }
}

// MARK: - HeaderSmallLabel

public final class HeaderSmallLabel: Label {
    override var style: LabelStyle? {
        .headerSmall()
    }
}

// MARK: - HeaderExtraSmallLabel

public final class HeaderExtraSmallLabel: Label {
    override var style: LabelStyle? {
        .headerExtraSmall()
    }
}

// MARK: - BodyExtraLargeLabel

public final class BodyExtraLargeLabel: Label {
    override var style: LabelStyle? {
        .bodyExtraLarge()
    }
}

// MARK: - BodyLargeLabel

public final class BodyLargeLabel: Label {
    override var style: LabelStyle? {
        .bodyLarge()
    }
}

// MARK: - BodyRegularLabel

public final class BodyRegularLabel: Label {
    override var style: LabelStyle? {
        .bodyRegular()
    }
}

// MARK: - BodySmallLabel

public final class BodySmallLabel: Label {
    override var style: LabelStyle? {
        .bodySmall()
    }
}

// MARK: - BodyXSmallLabel

public final class BodyXSmallLabel: Label {
    override var style: LabelStyle? {
        .bodyXSmall()
    }
}
