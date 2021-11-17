//
//  LoggersManager.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import Foundation

public enum LoggersManager {
    private static var engines: [LogEngine] {
        .all
    }

    public static func info(message: String) {
        engines.forEach { $0.info(message: message) }
    }

    public static func warn(message: String) {
        engines.forEach { $0.warn(message: message) }
    }

    public static func error(message: String) {
        engines.forEach { $0.error(message: message) }
    }

    public static func info(_ error: RSError) {
        guard error.code?.loggable ?? true == true else { return }
        engines.forEach { $0.info(message: "\(error)") }
    }

    public static func warn(_ error: RSError) {
        guard error.code?.loggable ?? true == true else { return }
        engines.forEach { $0.warn(message: "\(error)") }
    }

    public static func error(_ error: RSError) {
        guard error.code?.loggable ?? true == true else { return }
        engines.forEach { $0.error(message: "\(error)") }
    }
}

public extension String {
    func tagWith(_ tag: LogTag) -> String {
        withPrefix("\(tag.rawValue) ")
    }

    func tagWith(_ tags: [LogTag]) -> String {
        tags.map { "[\($0.rawValue)]" }.joined(separator: "").withPrefix(" \(self)")
    }

    func withPrefix(_ prefix: String) -> String {
        "\(prefix)\(self)"
    }
}
