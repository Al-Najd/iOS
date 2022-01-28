//
//  HapticService.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import Foundation
import CoreHaptics
import UIKit

class HapticService {
  static let main = HapticService()
  
  private let generator = UINotificationFeedbackGenerator()
  
  func generate(feedback type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
}
