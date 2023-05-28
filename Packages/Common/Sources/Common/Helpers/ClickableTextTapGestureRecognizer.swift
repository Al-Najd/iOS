//
//  ClickableTextTapGestureRecognizer.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import UIKit

// MARK: - ClickableTextTapGestureRecognizer

public final class ClickableTextTapGestureRecognizer: UITapGestureRecognizer {
    private var words: [ClickableWord]
    private weak var targetLabel: UILabel?

    init(
        words: [ClickableWord],
        targetLabel: UILabel) {
        self.words = words
        self.targetLabel = targetLabel
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(execute))
    }

    @objc
    private func execute() {
        guard let targetLabel = targetLabel else { return }
        guard let labelText = targetLabel.attributedText?.string ?? targetLabel.text else { return }
        words.forEach { [weak self] word in
            guard let self = self else { return }
            let wordRange = NSString(string: labelText).range(of: word.text)
            let didTapOnWord = self.didTapAttributedTextInLabel(label: targetLabel, inRange: wordRange)

            if didTapOnWord { word.onTapAction() }
        }
    }
}

// MARK: - ClickableWord

public struct ClickableWord {
    let text: String
    let onTapAction: () -> Void

    public init(text: String, onTapAction: @escaping () -> Void) {
        self.text = text
        self.onTapAction = onTapAction
    }
}

public extension UILabel {
    func onTapping(words: ClickableWord...) {
        let tap = ClickableTextTapGestureRecognizer(words: words, targetLabel: self)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}

private extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = location(in: label)

        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x,
            y: locationOfTouchInLabel.y)

        let indexOfCharacter = layoutManager.characterIndex(
            for: locationOfTouchInTextContainer,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
