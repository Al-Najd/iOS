//
//  Logger.swift
//  CAFU
//
//  Created by Ahmed Ramy on 15/10/2022.
//

import Foundation

// MARK: - Logger

public protocol Logger {
    func info(message: String, tags: [LogTag], file: String, function: String, metadata: [String: String])
    func warn(message: String, tags: [LogTag], file: String, function: String, metadata: [String: String])
    func error(message: String, tags: [LogTag], file: String, function: String, metadata: [String: String])
}

extension Logger {
    func info(message: String, tags: [LogTag], file: String, function: String) {
        info(message: message, tags: tags, file: file, function: function, metadata: [:])
    }

    func warn(message: String, tags: [LogTag], file: String, function: String) {
        warn(message: message, tags: tags, file: file, function: function, metadata: [:])
    }

    func error(message: String, tags: [LogTag], file: String, function: String) {
        error(message: message, tags: tags, file: file, function: function, metadata: [:])
    }
}

// MARK: - LogTag

public enum LogTag: String, CaseIterable {
    case `internal` = "[Internal]"
    case videoPlayer = "[Video Player]"
    case parsing = "[Parsing]"
    case encoding = "[Encoding]"
    case authentication = "[Authentication]"
    case firebase = "[Firebase]"
    case cache = "[Cache]"
    case network = "[Network]"
    case location = "[Location]"
    case download = "[Download]"
    case notifications = "[Notifications]"
    case payment = "[Payment]"
    case applePay = "[Apple Pay]"
    case identity = "[Identity]"
    case otp = "[OTP]"
    case timer = "[Timer]"
    case order = "[Order]"
    case lifecycle = "[Lifecycle]"
    case deeplink = "[Deeplink]"
    case debuggable = "[Debuggable]"
    case logout = "[Logout]"
    case retriever = "[Retriever]"
    case orderStatus = "[Order Status]"
    case analytics = "[Analytics]"
    case zones = "[Zones]"
}

// MARK: - Loggable

public protocol Loggable: CustomDebugStringConvertible { }

public extension Error {
    /// Side-effects the error logging and returning the error unchanged
    /// - Parameter tags: Tags needed to filter the error if needed
    /// - Returns: returns the error without changes
    func whileLogging(_ tags: [LogTag] = [], _ metadata: [String: String] = [:]) -> Self {
        log(tags, metadata)
        return self
    }

    /// Side-effects the error logging
    /// - Parameter tags: Tags needed to filter the error if needed
    func log(_ tags: [LogTag] = [], _ metadata: [String: String] = [:]) {
        Log.error(debugDescription, tags: tags, metadata: metadata)
    }

    var debugDescription: String {
        if let loggableError = self as? Loggable {
            return loggableError.debugDescription
        } else {
            return localizedDescription
        }
    }
}

// MARK: - LoggableWithContext

public protocol LoggableWithContext: Loggable {
    var context: String { get }
}

public extension Error where Self: LoggableWithContext {
    /// Side-effects the error logging and returning the error unchanged
    /// - Parameter tags: Tags needed to filter the error if needed
    /// - Returns: returns the error without changes
    func whileLogging(_ tags: [LogTag] = [], _ metadata: [String: String] = [:]) -> Self {
        var metadata = metadata
        metadata["Context"] = context
        log(tags, metadata)
        return self
    }

    /// Side-effects the error logging
    /// - Parameter tags: Tags needed to filter the error if needed
    func log(_ tags: [LogTag] = [], _ metadata: [String: String] = [:]) {
        var metadata = metadata
        metadata["Context"] = context
        Log.error(debugDescription, tags: tags, metadata: metadata)
    }
}
