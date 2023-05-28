//
//  PhoneTextField.swift
//  CAFU
//
//  Created by Ahmed Ramy on 21/09/2022.
//

import Configs
import Factory
import Foundation
import UIKit

// MARK: - PhoneTextField

@IBDesignable
public class PhoneTextField: TextField {
    @IBOutlet private weak var countryCodeLabel: UILabel!

    @Injected(\.authConfig)
    var authConfig

    @IBInspectable
    override public var text: String? {
        get { inputFormatter.unformat(textField.attributedText?.string) }
        set { textField.attributedText = textDecorator.decorate(newValue ?? "") }
    }

    @IBInspectable
    override public var placeholder: String? {
        get { inputFormatter.unformat(textField.attributedPlaceholder?.string) }
        set { textField.attributedPlaceholder = placeholderDecorator.decorate(newValue ?? "") }
    }

    public var countryCode: CountryCode? {
        try? countryCodeFormatter.parse(countryCodeLabel.text).get()
    }

    public var phoneNumber: PhoneNumber {
        .init(countryCode: countryCode?.code ?? "", number: text ?? "")
    }

    private let hapticFeedbackGenerator = HapticFeedbackGenerator()
    private let textDecorator: PhoneNumberTextDecorator
    private let placeholderDecorator: PhoneNumberPlaceholderTextDecorator
    private let inputFormatter: PhoneNumberTextInputFormatter
    private let countryCodeFormatter: CountryCodeFormatter

    init(
        textDecorator: PhoneNumberTextDecorator = .init(),
        placeholderDecorator: PhoneNumberPlaceholderTextDecorator = .init(),
        formatter: PhoneNumberTextInputFormatter = .init(),
        validator: PhoneNumberValidator = .init(),
        countryCodeFormatter: CountryCodeFormatter = .init()) {
        self.textDecorator = textDecorator
        self.placeholderDecorator = placeholderDecorator
        inputFormatter = formatter
        self.countryCodeFormatter = countryCodeFormatter
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        inputFormatter = .init()
        textDecorator = .init()
        placeholderDecorator = .init()
        countryCodeFormatter = .init()
        super.init(coder: aDecoder)
        textField.clearButtonMode = .whileEditing
        commonInit()
    }

    override public func commonInit() {
        super.commonInit()
        countryCodeLabel.text = CountryCode.default.display()
        textField.autocorrectionType = .yes
        textField.keyboardType = .phonePad
        textField.textContentType = .telephoneNumber
        placeholder = "(416) 395 – 8299"
        inputFormatter.countryCode = CountryCode.default.code
    }

    override public func handleStateChange() {
        switch state {
        case .error:
            hapticFeedbackGenerator.send(.error)
            outerBorderView.shake()
        default:
            break
        }
    }
}

// MARK: - UITextFieldDelegate Methods
extension PhoneTextField {
    open func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String)
        -> Bool {
        let result = inputFormatter.formatInput(
            currentText: textField.text ?? "",
            range: range,
            replacementString: string)
        text = result.formattedText
        textField.setCursorLocation(result.caretBeginOffset)
        textField.sendActions(for: .editingChanged)
        return false
    }
}

extension CountryCode {
    static let `default`: CountryCode = {
        let authConfig = Container.shared.authConfig()
        return .init(code: authConfig.countryCode, flagEmoji: authConfig.countryCodeFlag)
    }()
}
