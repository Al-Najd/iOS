//
//  File.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import Foundation

// MARK: - Report

public enum Report { }

public extension Report {
    struct Daily: Equatable {
        public let date: Date
        public let prayers: [Prayer]

        public init(date: Date, prayers: [Prayer]) {
            self.date = date
            self.prayers = prayers
        }
    }

    struct Range: Equatable {
        public let ranges: [Date: [Prayer]]

        public init(ranges: [Date: [Prayer]]) {
            self.ranges = ranges
        }
    }
}
