//
//  PulseLogger.swift
//  CAFU
//
//  Created by Ahmed Ramy on 16/10/2022.
//

import Foundation
import Pulse

// MARK: - PulseLogger

public final class PulseLogger: Logger {
    public static let main: PulseLogger = .init()

    private let logger = LoggerStore.shared
    public let networkLogger = Pulse.NetworkLogger()

    public func info(message: String, tags: [LogTag], file: String, function: String, metadata: [String: String]) {
        log(as: .info, message: message, tags: tags, file: file, function: function, metadata: metadata)
    }

    public func warn(message: String, tags: [LogTag], file: String, function: String, metadata: [String: String]) {
        log(as: .warning, message: message, tags: tags, file: file, function: function, metadata: metadata)
    }

    public func error(message: String, tags: [LogTag], file: String, function: String, metadata: [String: String]) {
        guard !tags.contains(.parsing) else { return }
        log(as: .error, message: message, tags: tags, file: file, function: function, metadata: metadata)
    }
}

private extension PulseLogger {
    func mapTagsToLabel(_ tags: [LogTag]) -> String {
        tags.map { $0
            .rawValue
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
        }
        .joined(separator: " ")
    }

    func log(
        as level: LoggerStore.Level,
        message: String,
        tags: [LogTag],
        file: String,
        function: String,
        metadata: [String: String]) {
        logger.storeMessage(
            label: mapTagsToLabel(tags),
            level: level,
            message: message,
            metadata: metadata.mapValues { .string($0) },
            file: file,
            function: function)
    }
}
