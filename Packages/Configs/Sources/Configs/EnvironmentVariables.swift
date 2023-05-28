//
//  EnvironmentVariables.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 27/09/2022.
//

import UIKit

public enum EnvironmentVariables {
    public static func value<T>(for key: String) -> T {
        guard let value = Bundle.main.infoDictionary?[key] as? T else {
            fatalError("Invalid or missing Info.plist key: \(key)")
        }
        return value
    }

    public static let AppVersion: String = value(for: kCFBundleVersionKey as String)

    public static let device = UIDevice.current
    public static let deviceName = device.name
    public static let deviceModel = device.model
    public static let deviceVersion = device.systemVersion

    public static let appId: String = value(for: kCFBundleIdentifierKey as String)

    public static let platform = "ios"
    public static let deviceManufacturer = "Appple"
    public static let providerFCM = "fcm"

    public static var baseURL: String {
        value(for: "BASE_URL" as String)
    }

    public static var GoogleMapsApiKey: String {
        value(for: "GOOGLE_MAPS_API_KEY" as String)
    }

    public static var ApplePayMerchantId: String {
        value(for: "APPLE_PAY_MERCHANT_ID" as String)
    }
}
