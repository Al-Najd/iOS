//
//  TextDecorator.swift
//  CAFU
//
//  Created by Ahmed Ramy on 22/09/2022.
//

import Foundation

public protocol TextDecorator {
    func decorate(_ text: String?) -> NSAttributedString?
}
