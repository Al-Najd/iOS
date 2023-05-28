//
//  NotificationRequest.swift
//
//
//  Created by Ahmed Ramy on 30/03/2023.
//

import Configs
import Foundation

// MARK: - NotificationRequest

public struct NotificationRequest: Encodable {
    var token: String
    var deviceManufacturer: String
    var deviceName: String
    var deviceModel: String
    var deviceVersion: String
    var appId: String
    var appVersion: String
    var platform: String
    var provider: String

    public init(token: String) {
        self.token = token
        deviceManufacturer = EnvironmentVariables.deviceManufacturer
        deviceName = EnvironmentVariables.deviceName
        deviceModel = EnvironmentVariables.deviceModel
        deviceVersion = EnvironmentVariables.deviceVersion
        appId = EnvironmentVariables.appId
        appVersion = EnvironmentVariables.AppVersion
        platform = EnvironmentVariables.platform
        provider = EnvironmentVariables.providerFCM
    }
}
