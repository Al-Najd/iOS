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
import ComposableCoreLocation

/**
 1. Check on press location permission
 2. when pressed let location manager fetch
 3. onAction, handle user interaction or route to settings
 */

public struct SettingsState: Equatable {
  @BindableState var enableAccessibilityFont: Bool = false
  var locationPermission: ANPermission = .location
  
  public init() {}
}

public enum SettingsAction: BindableAction, Equatable {
  case onAppear
  case locationManager(LocationManager.Action)
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
    case let .locationManager(.didChangeAuthorization(currentAuthorization)):
      state.locationPermission.status = .init(currentAuthorization)
    case .onAppear:
      state.enableAccessibilityFont = env.userDefaults.isFontAccessible
      state.locationPermission.status = .init(env.locationManager.authorizationStatus())
    case .binding(\.$enableAccessibilityFont):
      FontManager.shared.supportsAccessibilityAdaption = state.enableAccessibilityFont
      env.cache().save(state.enableAccessibilityFont, for: .enableAccessibilityFont)
    case let .onTapPermission(permission):
      return handlePermissionTap(permission, using: env)
        .eraseToEffect()
        .fireAndForget()
    case let .onTapModifier(modifier):
      openSettings()
    default:
      break
  }
  
  return .none
}
.binding()

fileprivate func handlePermissionTap(_ permission: ANPermission, using env: CoreEnvironment<SettingsEnvironment>) -> Effect<SettingsAction, Never> {
  switch permission.id {
    case ANPermission.location.id:
      return handleLocationPermission(permission, using: env)
    default:
      assertionFailure("Couldn't hanlde \(permission) in Settings")
      LoggersManager.error(message: "Couldn't hanlde \(permission) in Settings")
      break
  }
  
  return .none
}

fileprivate func handleLocationPermission(_ permission: ANPermission, using env: CoreEnvironment<SettingsEnvironment>) -> Effect<SettingsAction, Never> {
  switch permission.status {
    case .notDetermined:
      return .merge(
        env.locationManager
          .create(id: LocationId())
          .map(SettingsAction.locationManager),
        env.locationManager
          .requestWhenInUseAuthorization(id: LocationId())
          .fireAndForget()
      )
    case .given, .denied, .insufficient:
      openSettings()
      return .none
  }
}

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

private struct LocationId: Hashable {}
