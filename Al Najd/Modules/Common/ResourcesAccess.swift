//
//  ResourcesAccess.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 23/01/2022.
//




import Foundation

public extension OAnimation {
    static let splash: OAnimation = .init(name: "splash")
}

// MARK: - ImageKey

public enum ImageKey {
    public static let prayerWalkthrough = "prayer_walkthrough"
    public static let rewardsWalkthrough = "rewards_walkthrough"
    public static let azkarWalkthrough = "azkar_walkthrough"
    public static let dashboardWalkthrough = "dashboard_walkthrough"
    public static let calendarWalkthrough = "calendar_walkthrough"
    public static let dashboardInsightsWalkthrough = "dashboard_insights_walkthrough"
    public static let settingsWalkthrough = "settings_walkthrough"
}

public extension StorageKey {
    static let locationPermissionStatus: StorageKey = .init(key: "locationPermissionStatus", suitableStorage: .userDefaults)

    static let isNotificationsEnabled: StorageKey = .init(
        key: "isNotificationsEnabled",
        suitableStorage: .userDefaults)

    static let enableAccessibilityFont: StorageKey = .init(
        key: "enableAccessibilityFont",
        suitableStorage: .userDefaults)

    static let fontMultiplier: StorageKey = .init(
        key: "fontMultiplier",
        suitableStorage: .userDefaults)

    static let didCompleteOnboarding: StorageKey = .init(
        key: "didCompleteOnboarding",
        suitableStorage: .userDefaults)

    static let onboardingStep: StorageKey = .init(
        key: "onboardingStep",
        suitableStorage: .userDefaults)
}
