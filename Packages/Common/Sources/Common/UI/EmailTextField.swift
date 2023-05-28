//
//  EmailTextField.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 13/10/2022.
//

import Content
import UIKit

// MARK: - PhoneTextField

@IBDesignable
public class EmailTextField: TextField {
    private let validator: EmailValidator = .init()

    public var isValid: Bool {
        do {
            try validator.validate(self.text ?? "")
            return true
        } catch {
            return false
        }
    }

    override public func nibName() -> String {
        TextField.description().components(separatedBy: ".").last!
    }

    override public func commonInit() {
        super.commonInit()
        placeholder = L10n.generalEmailPlaceholder
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.autocorrectionType = .no
    }
}
