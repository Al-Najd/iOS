// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

import Foundation

public extension LoggerStore {
    struct Session: Codable, Sendable {
        public let id: UUID
        public let startDate: Date

        public init(id: UUID = UUID(), startDate: Date = Date()) {
            self.id = id
            self.startDate = startDate
        }

        /// Returns current log session.
        public static let current = Session()
    }
}
