//
//  Date+Extensions.swift
//  CAFU
//
//  Created by Ahmed Ramy on 06/10/2022.
//

import Foundation

public extension Date {
    /// User’s current calendar.
    var calendar: Calendar { Calendar.current }

    var isInToday: Bool {
        calendar.isDateInToday(self)
    }

    var isInYesterday: Bool {
        calendar.isDateInYesterday(self)
    }

    /// Date by adding multiples of calendar component.
    ///
    ///   let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///   let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///   let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///   let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///   let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of components to add.
    /// - Returns: original date + multiples of component added.
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        calendar.date(byAdding: component, value: value, to: self)!
    }

    /// Add calendar component to date.
    ///
    ///   var date = Date() // "Jan 12, 2017, 7:07 PM"
    ///   date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///   date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///   date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///   date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of component to add.
    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
}

public extension Date {
    // MARK: - Helper types

    enum DateFormatComponents: String {
        /// 1997
        case yearFull = "yyyy"
        /// 97 (1997)
        case yearShort = "yy"

        /// 7
        case monthDigit = "M"
        /// 07
        case monthDigitPadded = "MM"
        /// Jul
        case monthShort = "MMM"
        /// July
        case monthFull = "MMMM"
        /// J (July)
        case monthLetter = "MMMMM"

        /// 5
        case dayOfMonth = "d"

        /// Sat
        case weekdayShort = "EEE"
        /// Saturday
        case weekdayFull = "EEEE"
        /// S (Saturday)
        case weekdayLetter = "EEEEE"

        /// Localized **13** or **1 PM**, depending on the locale.
        case hour = "j"
        /// 20
        case minute = "m"
        /// 08
        case second = "ss"

        /// CST
        case timeZone = "zzz"
        /// **Central Standard Time** or **CST-06:00** or if full name is unavailable.
        case timeZoneFull = "zzzz"
    }

    func format(
        with components: [DateFormatComponents],
        in timeZone: TimeZone? = .current,
        using dateFormatter: DateFormatter = DateFormatter(),
        locale: Locale = .current)
        -> String? {
        let template = components.map(\.rawValue).joined(separator: " ")

        guard let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) else {
            return nil
        }

        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = localizedFormat

        return dateFormatter.string(from: self)
    }
}
