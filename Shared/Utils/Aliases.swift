//
//  Aliases.swift
//  Proba B.V.
//
//  Created by Ahmed Ramy on 9/30/20.
//  Copyright © 2020 Proba B.V. All rights reserved.
//

import Foundation

public typealias Expected<T> = Result<T, Error>
public typealias Handler<T> = (Expected<T>) -> Void
public typealias Callback<T> = (_: T) -> Void
public typealias VoidCallback = () -> Void
public typealias ProgressCallback<T> = Callback<Progress<T>>

public enum Progress<T> {
  case idle
  case loading
  case success(T)
  case failure(Error)
  
  var value: T? {
    switch self {
    case .success(let value): return value
    default: return nil
    }
  }
  
  var error: Error? {
    switch self {
    case .failure(let error): return error
    default: return nil
    }
  }
  
  var isLoading: Bool {
    switch self {
    case .loading: return true
    default: return false 
    }
  }
  
  var isIdle: Bool {
    switch self {
    case .idle: return true
    default: return false
    }
  }
}

extension Progress: Equatable where T: Equatable {
  public static func == (lhs: Progress<T>, rhs: Progress<T>) -> Bool {
    (lhs.value == rhs.value || lhs.error?.localizedDescription == rhs.error?.localizedDescription) && lhs.isLoading && rhs.isLoading
  }
}
