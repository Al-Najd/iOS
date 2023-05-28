//
//  Timeslot.swift
//  CAFU
//
//  Created by Ahmed Ramy on 27/10/2022.
//

import Foundation

struct TimeSlot: Codable {
    var startsAt, endsAt: Date

    func displayWithDates() -> String {
        TimeSlotFormatter.localizedString(startsAt: startsAt, endsAt: endsAt)
    }

    func displayWithTimeOnly() -> String {
        TimeSlotFormatter.localizeTimeSlot(start: startsAt, end: endsAt)
    }
}
