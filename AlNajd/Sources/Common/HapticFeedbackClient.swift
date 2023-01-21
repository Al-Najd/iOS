//
//  HapticService.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import CoreHaptics
import Foundation
import UIKit

public class HapticFeedbackClient {
    public static let main = HapticFeedbackClient()

    private let generator = UINotificationFeedbackGenerator()

    public func send(_ feedback: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(feedback)
    }
}
