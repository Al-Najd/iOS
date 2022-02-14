//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import Foundation

public extension Array where Element: Identifiable {
  mutating func findAndReplaceElseAppend(with replacer: Element) {
    if let index = firstIndex(where: { $0.id == replacer.id }) {
      self[index] = replacer
    } else {
      self.append(replacer)
    }
  }
  
  mutating func findAndReplace(with replacer: Element) {
    guard let index = firstIndex(where: { $0.id == replacer.id }) else { return }
    self[index] = replacer
  }
  
  mutating func findAndRemove(_ target: Element) {
    removeAll(where: { $0.id == target.id })
  }
}

public extension Array {
    func appending(_ elements: Element) -> Self {
        var current = self
        current.append(elements)
        return current
    }
    
    func appending(elements: [Element]) -> Self {
        var current = self
        current.append(contentsOf: elements)
        return current
    }
}

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

public protocol Changeable {}
public extension Changeable {
    func changing(_ change: (inout Self) -> Void) -> Self {
        var a = self
        change(&a)
        return a
    }
}

extension Array: Changeable where Element: Changeable {}
