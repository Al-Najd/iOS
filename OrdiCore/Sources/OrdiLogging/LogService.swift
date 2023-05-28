//
//  LogService.swift
//  CAFU
//
//  Created by Ahmed Ramy on 15/10/2022.
//

import Foundation

public typealias Log = LoggersService

// MARK: - LoggersService

public enum LoggersService {
    private static let logger: [Logger] = {
        [SystemLogger.main, PulseLogger.main]
    }()
}

// MARK: - Logging String
public extension LoggersService {
    static func info(
        _ message: String,
        tags: [LogTag] = [],
        file: String = #file,
        function: String = #function,
        metadata: [String: String] = [:]) {
        logger.forEach { $0.info(message: message, tags: tags, file: file, function: function, metadata: metadata) }
    }

    static func warn(
        _ message: String,
        tags: [LogTag] = [],
        file: String = #file,
        function: String = #function,
        metadata: [String: String] = [:]) {
        logger.forEach { $0.warn(message: message, tags: tags, file: file, function: function, metadata: metadata) }
    }

    static func error(
        _ message: String,
        tags: [LogTag] = [],
        file: String = #file,
        function: String = #function,
        metadata: [String: String] = [:]) {
        logger.forEach { $0.error(message: message, tags: tags, file: file, function: function, metadata: metadata) }
    }
}

// MARK: - Logging Loggables
public extension LoggersService {
    static func info(
        _ loggable: any Loggable,
        tags: [LogTag] = [],
        file: String = #file,
        function: String = #function,
        metadata: [String: String] = [:]) {
        logger.forEach { $0.info(message: loggable.debugDescription, tags: tags, file: file, function: function) }
    }

    static func warn(
        _ loggable: any Loggable,
        tags: [LogTag] = [],
        file: String = #file,
        function: String = #function,
        metadata: [String: String] = [:]) {
        logger.forEach { $0.warn(message: loggable.debugDescription, tags: tags, file: file, function: function) }
    }

    static func error(
        _ loggable: any Loggable,
        tags: [LogTag] = [],
        file: String = #file,
        function: String = #function,
        metadata: [String: String] = [:]) {
        logger.forEach { $0.error(message: loggable.debugDescription, tags: tags, file: file, function: function) }
    }
}
