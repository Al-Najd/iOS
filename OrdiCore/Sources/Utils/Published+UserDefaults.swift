//
//  Published+UserDefaults.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 28/10/2021.
//

import Combine
import Foundation

private var cancellables = [String:AnyCancellable]()

extension Published {
  init(wrappedValue defaultValue: Value, key: String) {
    let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
    self.init(initialValue: value)
    cancellables[key] = projectedValue.sink { val in
      UserDefaults.standard.set(val, forKey: key)
    }
  }
}
