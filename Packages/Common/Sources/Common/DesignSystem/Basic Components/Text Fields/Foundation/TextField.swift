//
//  TextField.swift
//  CAFU
//
//  Created by Ahmed Ramy on 01/10/2022.
//

import Combine
import UIKit

// MARK: - TextFieldComponent

public protocol TextFieldComponent {
    var state: TextField.State { get set }
    var placeholder: String? { get set }
    var text: String? { get set }
    var onChange: ((String?) -> Void)? { get set }
    var observedText: CurrentValueSubject<String?, Never> { get set }

    func getSuitableUISettings() -> TextField.UISettings
}

// MARK: - TextField

@IBDesignable
open class TextField: NibDesignable, TextFieldComponent {
    public var state: State = .idle {
        didSet {
            updateUISettings()
            handleStateChange()
        }
    }

    @IBOutlet public private(set) weak var outerBorderView: UIView!
    @IBOutlet public private(set) weak var innerBorderView: UIView!
    @IBOutlet public weak var textField: UITextField!
    @IBOutlet public private(set) weak var subtitle: UILabel!
    @IBOutlet public private(set) weak var trailingIconImageView: UIImageView!

    @IBInspectable
    open var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }

    @IBInspectable
    open var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }

    override public var bundle: Bundle { .module }

    open var observedText: CurrentValueSubject<String?, Never> = .init(nil)

    open var onChange: ((String?) -> Void)?
    open var shouldReturn: (() -> Void)?
    open var onEndEditing: (() -> Void)?

    public convenience init() {
        self.init()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    @objc
    open func textDidChange() {
        onChange?(text)
        observedText.send(text)
    }

    open func getSuitableUISettings() -> UISettings {
        switch state {
        case .idle:
            return .idle
        case .focused:
            return .focused
        case .disabled:
            return .disabled
        case .error:
            return .error
        }
    }

    open func commonInit() {
        textField.text = text
        textField.placeholder = placeholder
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        updateUISettings()
    }

    open func handleStateChange() {
        // NOTE: - Allows Children to react differently to state change
    }
}

// MARK: TextField.State

public extension TextField {
    enum State: Equatable {
        case idle
        case focused
        case disabled
        case error(String)

        public var error: String? {
            switch self {
            case .error(let reason):
                return reason
            default:
                return nil
            }
        }
    }
}

// MARK: UITextFieldDelegate

extension TextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_: UITextField) {
        state = .focused
    }

    public func textFieldDidEndEditing(_: UITextField) {
        state = .idle
        onEndEditing?()
    }

    public func textFieldShouldReturn(_: UITextField) -> Bool {
        shouldReturn?()
        return true
    }
}

private extension TextField {
    func updateUISettings() {
        let uiSettings = getSuitableUISettings()
        animate { [weak self] in
            guard let self = self else { return }
            self.outerBorderView.configure(using: uiSettings.outerBorder)
            self.innerBorderView.configure(using: uiSettings.innerBorder)
            self.innerBorderView.backgroundColor = uiSettings.backgroundColor
            self.textField.isEnabled = uiSettings.isEnabled
            self.subtitle.text = self.state.error
            self.subtitle.isHidden = self.state.error.isEmptyOrNil
            self.trailingIconImageView.image = uiSettings.trailingIcon
            self.trailingIconImageView.isHidden = uiSettings.trailingIcon == nil
        }
    }
}

public extension TextField {
    struct UISettings {
        public let innerBorder: BorderSettings
        public let outerBorder: BorderSettings
        public let isEnabled: Bool
        public let textColor: UIColor
        public let placeholderColor: UIColor
        public let backgroundColor: UIColor
        public let font: UIFont
        public let subtitleSettings: SubtitleUISettings
        public let trailingIcon: UIImage?

        public init(
            innerBorder: TextField.BorderSettings,
            outerBorder: TextField.BorderSettings,
            isEnabled: Bool = true,
            textColor: UIColor = .greyPrimaryGrey,
            placeholderColor: UIColor = .greyRegular,
            backgroundColor: UIColor = .greySuperlight,
            font: UIFont = .bodyRegular(),
            subtitleSettings: SubtitleUISettings = .none,
            trailingIcon: UIImage? = nil) {
            self.innerBorder = innerBorder
            self.outerBorder = outerBorder
            self.isEnabled = isEnabled
            self.textColor = textColor
            self.placeholderColor = placeholderColor
            self.backgroundColor = backgroundColor
            self.font = font
            self.subtitleSettings = subtitleSettings
            self.trailingIcon = trailingIcon
        }
    }

    struct BorderSettings {
        public let cornerRadius: CGFloat
        public let width: CGFloat
        public let color: UIColor

        init(
            cornerRadius: CGFloat,
            width: CGFloat,
            color: UIColor) {
            self.cornerRadius = cornerRadius
            self.width = width
            self.color = color
        }
    }

    struct SubtitleUISettings {
        public let color: UIColor
        public let isHidden: Bool
        public let font: UIFont

        public init(color: UIColor, isHidden: Bool, font: UIFont = .bodySmall()) {
            self.color = color
            self.isHidden = isHidden
            self.font = font
        }
    }
}

public extension TextField.UISettings {
    static let idle: TextField.UISettings = .init(
        innerBorder: .idleInnerBorder,
        outerBorder: .idleOuterBorder,
        backgroundColor: .greySuperlight)

    static let focused: TextField.UISettings = .init(
        innerBorder: .focusedInnerBorder,
        outerBorder: .focusedOuterBorder,
        backgroundColor: .greyWhite)

    static let disabled: TextField.UISettings = .init(
        innerBorder: .disabledInnerBorder,
        outerBorder: .disabledOuterBorder,
        isEnabled: false,
        textColor: .greyLighter,
        backgroundColor: .greyLight)

    static let error: TextField.UISettings = .init(
        innerBorder: .errorInnerBorder,
        outerBorder: .errorOutterBorder,
        backgroundColor: .greyWhite,
        subtitleSettings: .init(color: .redPrimaryRed, isHidden: false),
        trailingIcon: CAFUAssets.Errors.fieldErrorIcon.image)
}

public extension TextField.BorderSettings {
    // MARK: - Idle State
    static let idleInnerBorder: TextField.BorderSettings = .init(
        cornerRadius: 16,
        width: 0,
        color: .tealPrimaryTeal)

    static let idleOuterBorder: TextField.BorderSettings = .init(
        cornerRadius: 16,
        width: 0,
        color: .tealSuperlight)

    // MARK: - Focused State
    static let focusedInnerBorder: TextField.BorderSettings = .init(
        cornerRadius: 13.5,
        width: 1,
        color: .tealPrimaryTeal)

    static let focusedOuterBorder: TextField.BorderSettings = .init(
        cornerRadius: 16,
        width: 3,
        color: .tealSuperlight)

    // MARK: - Disabled State
    static let disabledInnerBorder: TextField.BorderSettings = .init(
        cornerRadius: 13.5,
        width: 0,
        color: .tealPrimaryTeal)

    static let disabledOuterBorder: TextField.BorderSettings = .init(
        cornerRadius: 16,
        width: 0,
        color: .tealSuperlight)

    // MARK: - Error State
    static let errorInnerBorder: TextField.BorderSettings = .init(
        cornerRadius: 13.5,
        width: 1,
        color: .redPrimaryRed)

    static let errorOutterBorder: TextField.BorderSettings = .init(
        cornerRadius: 16,
        width: 3,
        color: .redSuperlight)
}

public extension TextField.SubtitleUISettings {
    static let none = TextField.SubtitleUISettings(color: .clear, isHidden: true)
}
