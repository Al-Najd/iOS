//
//  HapticService.swift
//  The One
//
//  Created by Ahmed Ramy on 22/10/2021.
//

import Foundation
import CoreHaptics
import UIKit

class HapticService {
  static let main = HapticService()
  
  private let generator = UINotificationFeedbackGenerator()
  
  func generate(feedback type: UINotificationFeedbackGenerator.FeedbackType) {
    guard app.state.settingsState.allowHaptic else { return }
    generator.notificationOccurred(type)
  }
}
