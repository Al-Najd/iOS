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
  private var engine: CHHapticEngine?
  
  func generate(feedback type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
  
  func generateHoldFeedback(for duration: Double) {
    do {
      engine = try CHHapticEngine()
      let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.1)
      let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
      let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: duration)
      
      let pattern = try CHHapticPattern(events: [event], parameters: [])
      let player = try engine?.makePlayer(with: pattern)
      
      try engine?.start()
      try player?.start(atTime: 0)
    } catch let error {
      LoggersManager.error("\(error)")
    }
  }
  
  func stopHoldFeedback() {
    engine?.stop()
  }
}
