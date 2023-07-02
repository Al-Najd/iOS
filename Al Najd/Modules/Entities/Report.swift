//
//  File.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import Foundation

// MARK: - Report

public typealias PrayersRange = [Date: [Prayer]]

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
        public let range: PrayersRange

        public init(ranges: PrayersRange) {
            self.range = ranges
        }
    }
}
