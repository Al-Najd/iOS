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
