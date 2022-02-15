//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 15/02/2022.
//

import Foundation

/// Lightweight Observable Pattern
public class Dynamic<T> {
  
  private var bindings: [Callback<T>] = []
  
  public var value: T {
    didSet {
      update()
    }
  }
  
  public init(_ v :T) {
    value = v
  }
  
  private func update() {
    bindings.forEach {
      $0(value)
    }
  }
  
  public func bind(to binding: @escaping Callback<T>) {
    self.bindings.append(binding)
  }
}

extension Dynamic: Equatable where T: Equatable {
  public static func == (lhs: Dynamic<T>, rhs: Dynamic<T>) -> Bool {
    lhs.value == rhs.value
  }
}
