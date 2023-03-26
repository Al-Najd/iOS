//
//  CalendarSnapshotTests.swift
//
//
//  Created by Ahmed Ramy on 30/01/2022.
//

import Calendar
import DesignSystem
import SnapshotTesting
import Utils
import XCTest

class CalendarSnapshotTests: XCTestCase {
    let currentDate: Date = .now
    let calendar: Calendar = .current

    func testView() {
        let view = OCalendarView(calendar, .constant(currentDate)) { _ in }
        isRecording = true
        assertSnapshot(matching: view, as: .image(layout: .device(config: .iPhoneXsMax)))
    }
}
