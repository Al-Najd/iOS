//
//  ChargeTimeSlotFormatter.swift
//  CAFU
//
//  Created by Ahmed Allam on 17/10/2022.
//

import Content
import ContentEV
import Foundation
class TimeSlotFormatter {
    static func localizedString(startsAt startDate: Date, endsAt endDate: Date) -> String {
        let dayString = localizeStartDate(startDate)
        let timeSlot = localizeTimeSlot(start: startDate, end: endDate)
        return "\(dayString), \(timeSlot)"
    }

    private static func localizeStartDate(_ startDate: Date) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"

        var dayString = dayFormatter.string(from: startDate)
        if Calendar.current.isDateInToday(startDate) {
            dayString = L10n.generalToday
        }

        return dayString
    }

    static func localizeTimeSlot(start: Date, end: Date) -> String {
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "h:mma"

        let startsAtString = hourFormatter.string(from: start)
        let endsAtString = hourFormatter.string(from: end)

        return "\(startsAtString) - \(endsAtString)"
    }
}
