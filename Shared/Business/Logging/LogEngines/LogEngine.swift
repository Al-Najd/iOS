//
//  LogEngine.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import Foundation

public protocol LogEngine {
    func info(message: String)
    func warn(message: String)
    func error(message: String)
}

public enum LogTag: String {
    case `internal` = "[Internal]"
    case facebook = "[Facebook]"
    case parsing = "[Parsing]"
    case google = "[Google]"
    case authentication = "[Authentication]"
    case firebase = "[Firebase]"
    case cache = "[Cache]"
    case network = "[Network]"
    case download = "[Download]"
}

public extension Array where Element == LogEngine {
    static let all: [Element] = local + remote

    static let local: [Element] = [
        SystemLogger.main,
        PulseLogger.main,
    ]

    static let remote: [Element] = [
        SentryLogger.main,
    ]
}
