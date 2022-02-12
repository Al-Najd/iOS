//
//  PulseLogger.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/07/2021.
//  Copyright © 2021 Ahmed Ramy. All rights reserved.
//

import Pulse
import Logging

public final class PulseLogger: LogEngine {
    public static let main: PulseLogger = .init()

    private let logger = Logger(label: "com.RS.RS")
    private init() {
        LoggingSystem.bootstrap(PersistentLogHandler.init)
        URLSessionProxyDelegate.enableAutomaticRegistration()
    }

    public func info(message: String) {
        #if DEBUG
            logger.info(Logger.Message(stringLiteral: message))
        #endif
    }

    public func warn(message: String) {
        #if DEBUG
            logger.warning(Logger.Message(stringLiteral: message))
        #endif
    }

    public func error(message: String) {
        #if DEBUG
            logger.error(Logger.Message(stringLiteral: message))
        #endif
    }
}
