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
        log(tags, metadata.with { $0["Context"] = context })
        return self
    }

    /// Side-effects the error logging
    /// - Parameter tags: Tags needed to filter the error if needed
    func log(_ tags: [LogTag] = [], _ metadata: [String: String] = [:]) {
        Log.error(debugDescription, tags: tags, metadata: metadata.with { $0["Context"] = context })
    }
}

// MARK: - Updateable

public protocol Updateable { }

public extension Updateable where Self: Any {
    /// Makes it available to set properties with closures just after initializing and copying the value types.
    ///
    ///     let frame = CGRect().with {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///     }
    @inlinable
    func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }

    /// Makes it available to execute something with closures.
    ///
    ///     UserDefaults.standard.do {
    ///       $0.set("devxoul", forKey: "username")
    ///       $0.set("devxoul@gmail.com", forKey: "email")
    ///       $0.synchronize()
    ///     }
    @inlinable
    func `do`(_ block: (Self) throws -> Void) rethrows {
        try block(self)
    }
}

public extension Updateable where Self: AnyObject {
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().then {
    ///       $0.textAlignment = .center
    ///       $0.textColor = UIColor.black
    ///       $0.text = "Hello, World!"
    ///     }
    @inlinable
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

// MARK: - NSObject + Updateable

extension NSObject: Updateable { }

// MARK: - Array + Updateable

extension Array: Updateable { }

// MARK: - Dictionary + Updateable

extension Dictionary: Updateable { }

// MARK: - Set + Updateable

extension Set: Updateable { }

// MARK: - JSONDecoder + Updateable

extension JSONDecoder: Updateable { }

// MARK: - JSONEncoder + Updateable

extension JSONEncoder: Updateable { }
