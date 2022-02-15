//
//  SettingsFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/02/2022.
//

import Foundation
import Localization
import Entities
import UIKit
import ComposableArchitecture

public struct SettingsState: Equatable {
  let permissions: [ANPermission] = [.location]
  let modifiers: [ANSettingsModifier]
}

public enum SettingsAction: Equatable {
  case onAppear
  case onTapPermission(ANPermission)
  case onSwitchModifier(ANSettingsModifier, isTurnedOn: Bool)
  case onTapModifier(ANSettingsModifier)
}

public enum SettingsEnvironment { }

public let settingsReducer = Reducer<
  SettingsState,
  SettingsAction,
  SettingsEnvironment
>.init { state, action, env in
  switch action {
  case .onAppear:
    break
  case let .onTapPermission(permission):
    break
  case let .onTapModifier(modifier):
    break
  case let .onSwitchModifier(modifier, isTurnedOn):
    break
  }
}


// MARK: - Static Configurations Declaration
public extension ANPermission {
  private static let appBundleId = "com.nerdor.theone.The-One"
  static let location: ANPermission = .init(
    title: "Location".localized,
    icon: "location.circle.fill",
    subtitles: "Utilizes your device's GPS to determine latitude & longitude".localized,
    needs: [
      "Determines prayer times".localized,
      "Sets up Calendar events on Prayer times to notify you before hand (Configurable)".localized,
      "Sets up a reminder before Azhan by 15 minutes to pray Sunnah and attend first line in Prayer".localized
    ],
    type: .iOS(url: "prefs:root=Privacy&path=LOCATION/\(appBundleId)")
  )
}
public extension ANSettingsModifier {
  private static let appBundleId = "com.nerdor.theone.The-One"
  static let fontAccessibility: ANSettingsModifier = .init(
    title: "Font Accessibility".localized,
    icon: "eye.trianglebadge.exclamationmark.fill",
    subtitles: "Increases or decreases the font size for better reading experience without straining your eye very much".localized,
    isEnabled: false,
    url: "prefs:root=DISPLAY&path=TEXT_SIZE"
  )
}
