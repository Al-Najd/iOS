//
//  Dispatch+Additions.swift
//  Proba B.V.
//
//  Created by Ahmed Ramy on 24/04/2021.
//

import Foundation

public func after(on queue: DispatchQueue = .main, seconds: Double, execute: @escaping VoidCallback) {
  let time: DispatchTime = .now() + seconds
  queue.asyncAfter(deadline: time, execute: execute)
}

public func after(on queue: DispatchQueue = .main, seconds: Double, execute: DispatchWorkItem) {
  let time: DispatchTime = .now() + seconds
  queue.asyncAfter(deadline: time, execute: execute)
}

public func async(on queue: DispatchQueue = .main, execute: @escaping VoidCallback) {
  queue.async(execute: execute)
}

public extension DispatchQueue {
  static let userInitiated: DispatchQueue = .global(qos: .userInitiated)
}

public func safeSync(execute: VoidCallback) {
  if Thread.isMainThread {
    execute()
  }
  else {
    DispatchQueue.main.sync(execute: execute)
  }
}
