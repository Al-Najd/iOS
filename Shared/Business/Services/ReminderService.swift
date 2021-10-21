//
//  ReminderService.swift
//  The One (iOS)
//
//  Created by Ahmed Ramy on 17/10/2021.
//

import Foundation

protocol Remindable {
  var startTime: Date { get set }
  var endTime: Date { get set }
  var repeats: Bool { get set }
}

protocol ReminderServiceProtocol {
  var repeatTheCycleDate: Date { get }
}

final class ReminderService: ReminderServiceProtocol {
  var repeatTheCycleDate: Date {
    .now.firstDayOfTheWeek
  }
  
  func scheduleLocalNotification(for deed: Deed) {
    
  }
}
