//
//  HapticService.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import CoreHaptics
import Foundation
import UIKit
import ComposableArchitecture

public struct HapticFeedbackClient {

    private let generator = UINotificationFeedbackGenerator()

    public func send(_ feedback: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(feedback)
    }
}

extension HapticFeedbackClient: DependencyKey {
    public static let liveValue = HapticFeedbackClient()
}

public extension DependencyValues {
    var haptic: HapticFeedbackClient {
        get { self[HapticFeedbackClient.self] }
        set { self[HapticFeedbackClient.self] = newValue }
    }
}
