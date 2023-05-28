//
//  Dispatch+Additions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/12/2022.
//

import Foundation

public func asyncAfter(on queue: DispatchQueue = .main, seconds: Double, execute: @escaping () -> Void) {
    let time: DispatchTime = .now() + seconds
    queue.asyncAfter(deadline: time, execute: execute)
}

public func safeAsync(execute: @escaping () -> Void) {
    if Thread.isMainThread {
        execute()
    } else {
        DispatchQueue.main.async(execute: execute)
    }
}
