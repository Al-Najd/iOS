//
//  HapticFeedbackGenerator.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/12/2022.
//

import CoreHaptics
import Foundation
import UIKit

public class HapticFeedbackGenerator {
    private let generator = UINotificationFeedbackGenerator()

    public init() { }

    public func send(_ feedback: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(feedback)
    }
}
