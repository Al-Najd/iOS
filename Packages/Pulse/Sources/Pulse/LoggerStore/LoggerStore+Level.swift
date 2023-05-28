// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

public extension LoggerStore {
    @frozen
    enum MetadataValue {
        case string(String)
        case stringConvertible(CustomStringConvertible)
    }

    typealias Metadata = [String: MetadataValue]

    // Compatible with SwiftLog.Logger.Level
    @frozen
    enum Level: Int16, CaseIterable, Codable, Hashable, Sendable, RawRepresentable, Comparable, CustomStringConvertible {
        case trace = 1
        case debug = 2
        case info = 3
        case notice = 4
        case warning = 5
        case error = 6
        case critical = 7

        public var name: String {
            switch self {
            case .trace: return "trace"
            case .debug: return "debug"
            case .info: return "info"
            case .notice: return "notice"
            case .warning: return "warning"
            case .error: return "error"
            case .critical: return "critical"
            }
        }

        public var description: String { name }

        public static func < (lhs: LoggerStore.Level, rhs: LoggerStore.Level) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}

extension Dictionary where Key == String, Value == LoggerStore.MetadataValue {
    func unpack() -> [String: String] {
        var entries = [String: String]()
        for (key, value) in self {
            switch value {
            case .string(let string): entries[key] = string
            case .stringConvertible(let string): entries[key] = string.description
            }
        }
        return entries
    }
}
