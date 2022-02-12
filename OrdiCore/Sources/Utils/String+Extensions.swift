//
//  String+Extensions.swift
//  String+Extensions
//
//  Created by Ahmed Ramy on 23/08/2021.
//

import Foundation

public extension String {
  static let empty = ""
  
  func toURL() -> URL? {
    URL(string: self)
  }
  
  var asError: Error {
    return NSError(domain: self, code: -1, userInfo: [NSLocalizedDescriptionKey: self])
  }
  
  func matches(_ regex: String) -> Bool {
    return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
  }
}

public extension Optional where Wrapped == String {
  var emptyIfNil: String {
    return self ?? .empty
  }
  var dotIfNil: String {
    return self ?? "."
  }
}

public extension Optional where Wrapped == NSAttributedString {
  
  var emptyIfNil: NSAttributedString {
    return self ?? NSAttributedString(string: .empty)
  }
}

public extension String {
  
  var trimCardNumber: String {
    return self.replacingOccurrences(of: "*", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  func replacingOccurrences(with this: [String]) -> String {
    var value = self
    this.forEach { value = value.replacingOccurrences(of: $0, with: "") }
    return value
  }
  
  var trimPhoneNumber: String {
    return self.replacingOccurrences(of: "(", with: "")
      .replacingOccurrences(of: ")", with: "")
      .replacingOccurrences(of: "-", with: "")
      .replacingOccurrences(of: " ", with: "")
      .trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

public extension Int {
    func format(as formattingStyle: NumberFormatter.Style) -> String {
        NumberFormatter().then { $0.numberStyle = formattingStyle }.string(from: NSNumber(value: self)) ?? "..."
    }
}
