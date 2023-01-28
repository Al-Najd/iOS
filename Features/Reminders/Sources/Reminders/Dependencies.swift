//
//  Dependencies.swift
//  Reminders
//
//  Created by Ahmed Ramy on 28/01/2023.
//  Copyright © 2023 Al Najd. All rights reserved.
//

import AVFoundation
import ComposableArchitecture
import Foundation
import uAudioFeedback
import UIKit

// MARK: - AudioFeedbackClient

struct AudioFeedbackClient {
    var audio: AudioController
}

// MARK: DependencyKey

extension AudioFeedbackClient: DependencyKey {
    static let liveValue = Self(audio: .shared)
}

extension DependencyValues {
    var feedback: AudioFeedbackClient {
        get { self[AudioFeedbackClient.self] }
        set { self[AudioFeedbackClient.self] = newValue }
    }
}

// MARK: - Vibration

enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    @available(iOS 13.0, *)
    case soft
    @available(iOS 13.0, *)
    case rigid
    case selection
    case oldSchool

    public func vibrate() {
        switch self {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
        case .rigid:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
