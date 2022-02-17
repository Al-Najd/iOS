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
import OrdiLogging
import ComposableArchitecture
import DesignSystem
import Utils
import SwiftUI
import Common

public struct SettingsState: Equatable {
  @BindableState var enableAccessibilityFont: Bool = false
  var permissions: [ANPermission] = []
  
  public init() {}
}

public enum SettingsAction: BindableAction, Equatable {
  case onAppear
  case binding(BindingAction<SettingsState>)
  case onTapPermission(ANPermission)
  case onSwitchModifier(ANSettingsModifier, isTurnedOn: Bool)
  case onTapModifier(ANSettingsModifier)
}

public struct SettingsEnvironment { public init() { } }

public let settingsReducer = Reducer<
  SettingsState,
  SettingsAction,
  CoreEnvironment<SettingsEnvironment>
>.init { state, action, env in
  switch action {
    case .onAppear:
      state.permissions = []
      
      state.enableAccessibilityFont = env.cache().fetch(Bool.self, for: .enableAccessibilityFont) ?? false
    case .binding(\.$enableAccessibilityFont):
      FontManager.shared.supportsAccessibilityAdaption = state.enableAccessibilityFont
      env.cache().save(state.enableAccessibilityFont, for: .enableAccessibilityFont)
    case let .onTapPermission(permission):
      openSettings()
    case let .onTapModifier(modifier):
      openSettings()
    default:
      break
  }
  
  return .none
}.binding()

fileprivate func openURL(using stringURL: String?, _ title: String) {
  guard let urlString = stringURL, let url = URL.init(string: urlString) else { return }
  guard UIApplication.shared.canOpenURL(url) else {
    LoggersManager.error(message: "Couldn't open \(url) for \(title)")
    return
  }
  
  UIApplication.shared.open(url)
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
    isInternal: true
  )
}
public extension ANSettingsModifier {
  private static let appBundleId = "com.nerdor.theone.The-One"
  static let fontAccessibility: ANSettingsModifier = .init(
    title: "Font Accessibility".localized,
    icon: "eyeglasses",
    subtitles: "Increases or decreases the font size for better reading experience without straining your eye very much",
    isInternal: false
  )
}

extension ANSettingsModifier: Then { }
extension ANPermission: Then {}

public extension Store where State == SettingsState, Action == SettingsAction {
  static let live: Store<State, Action> = .init(
    initialState: .init(),
    reducer: settingsReducer,
    environment: .live(
      SettingsEnvironment()
    )
  )
}