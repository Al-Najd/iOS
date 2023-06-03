//
//  SentryLogger.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import Sentry

// MARK: - SentryService

public enum SentryService {
    public static func setup() {
        SentrySDK.start { options in
            options.dsn = Configurations.default.dsn
            options.debug = Configurations.default.debug
            options.environment = Configurations.default.environment
            options.tracesSampleRate = Configurations.default.traceSampleRate
        }
    }
}

// MARK: SentryService.Configurations

private extension SentryService {
    struct Configurations {
        let dsn: String
        let debug: Bool
        let traceSampleRate: NSNumber

        #if DEBUG
        let environment = "Development"
        #elseif ALPHA
        let environment = "Alpha"
        #elseif BETA
        let environment = "Beta"
        #else
        let environment = "Production"
        #endif

        static let `default`: Configurations = .init(
            dsn: "https://0526add1e72543819237e2018fa6b72e@o455344.ingest.sentry.io/6031596",
            debug: false,
            traceSampleRate: 1.0
        )
    }
}

// MARK: - SentryLogger

final class SentryLogger: Logger {
    public static let main: SentryLogger = .init()

    private func createEvent(
        level: SentryLevel,
        message: String,
        tags: [LogTag],
        file: String = "",
        function: String = "",
        metadata: [String: String] = [:]) -> Event {
        let level: SentryLevel = .info
        let event = Event(level: level)
        event.message = SentryMessage(formatted: message)
        return event
    }

    public func info(
        message: String,
        tags: [LogTag],
        file: String = "",
        function: String = "",
        metadata: [String: String] = [:]) {
            SentrySDK.capture(event: createEvent(level: .info, message: message, tags: tags, metadata: metadata))
    }

    public func warn(
        message: String,
        tags: [LogTag],
        file: String = "",
        function: String = "",
        metadata: [String: String] = [:]) {
            SentrySDK.capture(event: createEvent(level: .warning, message: message, tags: tags, metadata: metadata))
    }

    public func error(
        message: String,
        tags: [LogTag],
        file: String = "",
        function: String = "",
        metadata: [String: String] = [:]) {
            SentrySDK.capture(event: createEvent(level: .error, message: message, tags: tags, metadata: metadata))
    }
}
