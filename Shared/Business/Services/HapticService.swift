//
//  HapticService.swift
//  The One
//
//  Created by Ahmed Ramy on 22/10/2021.
//

import Foundation
import UIKit

class HapticService {
  static let main = HapticService()
  private let generator = UINotificationFeedbackGenerator()
  
  func generate(feedback type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
}
