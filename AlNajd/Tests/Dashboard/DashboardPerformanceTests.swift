//
//  DashboardPerformanceTests.swift
//
//
//  Created by Ahmed Ramy on 13/02/2022.
//

import XCTest
@testable import Dashboard
@testable import Entities

class DashboardPerformanceTests: XCTestCase {
    let goodWeekSeeder: (inout [Date: [Deed]], Date) -> Void = { dictionary, date in
        var deeds: [Deed] = .faraaid
        (0 ... 3).forEach { deeds[$0].isDone = true }
        dictionary[date] = deeds
    }

    let badWeekSeeder: (inout [Date: [Deed]], Date) -> Void = { dictionary, date in
        var deeds: [Deed] = .faraaid
        (0 ... 1).forEach { deeds[$0].isDone = true }
        dictionary[date] = deeds
    }

    func testAnalysisOfCurrentWeekOnly() throws {
        let currentWeekFakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]](), goodWeekSeeder)
        measure {
            _ = analyize(
                currentRangeReport: .init(ranges: [
                    .fard: currentWeekFakeData,
                    .sunnah: currentWeekFakeData,
                    .nafila: currentWeekFakeData,
                ]))
        }
    }

    func testAnalysisOfCurrentWeekAndPreviousWeek() throws {
        let currentWeekFakeData = Date.now.previousWeek.reduce(into: [Date: [Deed]](), goodWeekSeeder)
        let previousWeekFakeData = Date.now.adding(.day, value: -7).previousWeek.reduce(into: [Date: [Deed]](), badWeekSeeder)
        measure {
            _ = analyize(
                currentRangeReport: .init(ranges: [
                    .fard: currentWeekFakeData,
                    .sunnah: currentWeekFakeData,
                    .nafila: currentWeekFakeData,
                ]),
                previousRangeReport: .init(ranges: [
                    .fard: previousWeekFakeData,
                    .sunnah: previousWeekFakeData,
                    .nafila: previousWeekFakeData,
                ]))
        }
    }
}
