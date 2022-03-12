//
//  ResourcesAccess.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 23/01/2022.
//

import Foundation
import Animations
import Business
import Entities

public extension OAnimation {
  static let splash: OAnimation = .init(name: "splash")
}

public enum ImageKey {
  public static let prayerWalkthrough: String = "prayer_walkthrough"
  public static let rewardsWalkthrough: String = "rewards_walkthrough"
  public static let azkarWalkthrough: String = "azkar_walkthrough"
  public static let dashboardWalkthrough: String = "dashboard_walkthrough"
  public static let calendarWalkthrough: String = "calendar_walkthrough"
  public static let dashboardInsightsWalkthrough: String = "dashboard_insights_walkthrough"
  public static let settingsWalkthrough: String = "settings_walkthrough"
}

public extension StorageKey {
    static let locationPermissionStatus: StorageKey = .init(key: "locationPermissionStatus", suitableStorage: .userDefaults)
    
  static let prayers: (_ date: Date, _ category: DeedCategory) -> StorageKey = {
    .init(
      key: "\($0.day)-\($0.month)-\($0.year)-\($1)-prayers",
      suitableStorage: .userDefaults
    )
  }
  
  static let azkar: (_ date: Date, _ category: AzkarCategory) -> StorageKey = {
    .init(
      key: "\($0.day)-\($0.month)-\($0.year)-\($1)-azkar",
      suitableStorage: .userDefaults
    )
  }
  
  static let prayersRewards: (_ date: Date, _ category: DeedCategory) -> StorageKey = {
    .init(
      key: "\($0.day)-\($0.month)-\($0.year)-\($1)-prayers-rewards",
      suitableStorage: .userDefaults
    )
  }
  
  static let azkarRewards: (_ date: Date, _ category: AzkarCategory) -> StorageKey = {
    .init(
      key: "\($0.day)-\($0.month)-\($0.year)-\($1)-azkar-rewards",
      suitableStorage: .userDefaults
    )
  }
  
    static let isNotificationsEnabled: StorageKey = .init(
        key: "isNotificationsEnabled",
        suitableStorage: .userDefaults
    )
    
  static let enableAccessibilityFont: StorageKey = .init(
    key: "enableAccessibilityFont",
    suitableStorage: .userDefaults
  )
  
  static let fontMultiplier: StorageKey = .init(
    key: "fontMultiplier",
    suitableStorage: .userDefaults
  )
  
  static let didCompleteOnboarding: StorageKey = .init(
    key: "didCompleteOnboarding",
    suitableStorage: .userDefaults
  )
  
  static let onboardingStep: StorageKey = .init(
    key: "onboardingStep",
    suitableStorage: .userDefaults
  )
}
public extension StorageKey {
  static let standard: StandardEntity = .main
 
  /// Represents Standard set of Data without any user interactions
  /// Used to seed the iOS project with data for Prayers and Azkars
  struct StandardEntity {
    static let main: StandardEntity = .init()
    let prayers: (_ category: DeedCategory) -> StorageKey = {
      .init(
        key: "\($0.id)-prayer",
        suitableStorage: .userDefaults
      )
    }
    
    let azkar: (_ category: AzkarCategory) -> StorageKey = {
      .init(
        key: "\($0.id)-azkar",
        suitableStorage: .userDefaults
      )
    }
  }
}

class CurrentBundleFinder {}
public extension Foundation.Bundle {
  
  static var commonBundle: Bundle = {
    /* The name of your local package, prepended by "LocalPackages_" */
    let bundleName = "AlNajd_Common"
    let candidates = [
      /* Bundle should be present here when the package is linked into an App. */
      Bundle.main.resourceURL,
      /* Bundle should be present here when the package is linked into a framework. */
      Bundle(for: CurrentBundleFinder.self).resourceURL,
      /* For command-line tools. */
      Bundle.main.bundleURL,
      /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
      Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
    ]
    for candidate in candidates {
      let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
      if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
        return bundle
      }
    }
    fatalError("unable to find bundle named \(bundleName)")
  }()
}
