//
//  TimeOfCompletionFormatter.swift
//  CAFU
//
//  Created by Ahmed Ramy on 30/11/2022.
//

import Content
import ContentEV
import Foundation
import Localization

class TimeOfCompletionFormatter {
//    static func localizedString(for date: Date) -> String {
//        L10n.orderDetailsWhenValueTitle(getDay(of: date), getTime(of: date))
//    }

    private static func getDay(of date: Date) -> String {
        if date.isInToday {
            return L10n.generalToday
        } else if date.isInYesterday {
            return L10n.generalYesterday
        } else {
            return date.format(with: [.dayOfMonth, .monthDigit, .yearFull]) ?? L10n.generalUnknownDay
        }
    }

    private static func getTime(of date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        dateFormatter.doesRelativeDateFormatting = false
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = LocalizationService.shared.currentLanguage.locale

        return dateFormatter.string(from: date)
    }
}
