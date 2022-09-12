//  swiftlint:disable all
//
//  The code generated using FigmaExport — Command line utility to export
//  colors, typography, icons and images from Figma to Xcode project.
//
//  https://github.com/RedMadRobot/figma-export
//
//  Don’t edit this code manually to avoid runtime crashes
//

import UIKit

public class Label: UILabel {

    var style: LabelStyle? { nil }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
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
    }

    private func updateText() {
        text = super.text
    }

    public override var text: String? {
        get {
            guard style?.attributes != nil else {
                return super.text
            }

            return attributedText?.string
        }
        set {
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

public final class BodyExtraLargeLabel: Label {

    override var style: LabelStyle? {
        .bodyExtraLarge()
    }
}

public final class BodyExtraLargeBoldLabel: Label {

    override var style: LabelStyle? {
        .bodyExtraLargeBold()
    }
}

public final class BodyExtraSmallBoldLabel: Label {

    override var style: LabelStyle? {
        .bodyExtraSmallBold()
    }
}

public final class BodyLargeBoldLabel: Label {

    override var style: LabelStyle? {
        .bodyLargeBold()
    }
}

public final class BodyRegularBoldLabel: Label {

    override var style: LabelStyle? {
        .bodyRegularBold()
    }
}

public final class BodySmallBoldLabel: Label {

    override var style: LabelStyle? {
        .bodySmallBold()
    }
}

public final class BodyExtraSmallLabel: Label {

    override var style: LabelStyle? {
        .bodyExtraSmall()
    }
}

public final class BodyLargeLabel: Label {

    override var style: LabelStyle? {
        .bodyLarge()
    }
}

public final class BodyRegularLabel: Label {

    override var style: LabelStyle? {
        .bodyRegular()
    }
}

public final class BodySmallLabel: Label {

    override var style: LabelStyle? {
        .bodySmall()
    }
}

public final class ButtonsLargeLabel: Label {

    override var style: LabelStyle? {
        .buttonsLarge()
    }
}

public final class ButtonsRegularLabel: Label {

    override var style: LabelStyle? {
        .buttonsRegular()
    }
}

public final class HeadersLargeLabel: Label {

    override var style: LabelStyle? {
        .headersLarge()
    }
}

public final class HeadersSmallLabel: Label {

    override var style: LabelStyle? {
        .headersSmall()
    }
}

public final class HeadersSubheadlineLabel: Label {

    override var style: LabelStyle? {
        .headersSubheadline()
    }
}

public final class HeadersExtraLargeLabel: Label {

    override var style: LabelStyle? {
        .headersExtraLarge()
    }
}

public final class HeadersRegularLabel: Label {

    override var style: LabelStyle? {
        .headersRegular()
    }
}

public final class IosHeaderExtraLargeLabel: Label {

    override var style: LabelStyle? {
        .iosHeaderExtraLarge()
    }
}

public final class IosHeaderLargeLabel: Label {

    override var style: LabelStyle? {
        .iosHeaderLarge()
    }
}

public final class IosHeaderMediumLabel: Label {

    override var style: LabelStyle? {
        .iosHeaderMedium()
    }
}

public final class IosHeaderRegularLabel: Label {

    override var style: LabelStyle? {
        .iosHeaderRegular()
    }
}

public final class IosHeaderSmallLabel: Label {

    override var style: LabelStyle? {
        .iosHeaderSmall()
    }
}

public final class IosBodyExtraLargeLabel: Label {

    override var style: LabelStyle? {
        .iosBodyExtraLarge()
    }
}

public final class IosBodyLargeLabel: Label {

    override var style: LabelStyle? {
        .iosBodyLarge()
    }
}

public final class IosBodyRegularLabel: Label {

    override var style: LabelStyle? {
        .iosBodyRegular()
    }
}

public final class IosBodySmallLabel: Label {

    override var style: LabelStyle? {
        .iosBodySmall()
    }
}
