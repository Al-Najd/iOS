//
//  SchedulerService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 18/11/2021.
//

import Foundation
import Schedule
import SwiftUI
import SPIndicator

/**
 * Imagination:
 * ```
 * Scheduler.every(5.minutes).then { scheduler in
 *    scheduler.do(remindUserToDoEst8far)
 *    scheduler.do(remindUserToDoDuaaForSatr)
 * }
 *
 * Scheduler.every(25.minutes).tehn { scheduler in
 *    UserPreferencesService.getRemindableDeedsForEach(25.minutes).forEach { scheduler.do($0) }
 * }
 * ```
 */



public struct ANPlan: Identifiable {
  public var id: UUID = .init()
  let interval: Interval
  let action: ReminderAction
  let title: String
  let description: String
  let purpose: String
  let image: Image
  let brandColor: BrandColor
}

public struct SchedulerService {
  static var activePlans: [UUID: Task] = [:]
  
  static func schedule(_ plan: ANPlan) {
    if activePlans[plan.id] != nil {
      SPIndicatorView(title: "Plan already scheduled...", preset: .error)
        .present(
          duration: 3,
          haptic: .error
        )
    } else {
      activePlans[plan.id] = Plan.every(plan.interval).do(action: { ReminderService.remindUser(to: plan.action) })
      SPIndicatorView(title: "Plan Started!", preset: .done)
        .present(
          duration: 3,
          haptic: .success
        )
    }
  }
}
