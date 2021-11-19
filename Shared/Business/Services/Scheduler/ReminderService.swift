//
//  ReminderService.swift
//  The One (iOS)
//
//  Created by Ahmed Ramy on 17/10/2021.
//

import Foundation
import UserNotifications
import SPIndicator

public struct Notification: Identifiable {
  public var id: String { "\(title)-\(body)-\(subtitle)" }
  var title: String
  var body: String
  var subtitle: String
  var sound: UNNotificationSound
}

public enum ReminderAction {
  case estigphar
  
  var notification: Notification {
    switch self {
    case .estigphar:
      return .init(
        title: "Estigphar Plan",
        body: "Estigphar Plan Description",
        subtitle: "Estigphar Plan Purpose",
        sound: UNNotificationSound(named: .init(rawValue: MusicService.Effect.splashEnd.name))
      )
    }
  }
}

public final class ReminderService {
  public static func remindUser(to action: ReminderAction) {
    let content = UNMutableNotificationContent()
    content.title = action.notification.title.localized
    content.body = action.notification.body.localized
    content.subtitle = action.notification.subtitle.localized
    content.sound = action.notification.sound
        
    let request = UNNotificationRequest(
      identifier: action.notification.id,
      content: content,
      trigger: nil
    )
    
    UNUserNotificationCenter.current().add(request) { error in
      guard let error = error else { return }
      LoggersManager.error(RSErrorParser().parse(error))
    }
  }
}
