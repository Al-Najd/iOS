//
//  File.swift
//
//
//  Created by Ahmed Ramy on 30/03/2023.
//

import Configs
import Foundation

public extension Notification {
    static let userNeedsToReauthenticate = Notification(name: .userNeedsToReauthenticate)
}

public extension Notification.Name {
    static let userNeedsToReauthenticate: Notification.Name = .init(rawValue: "network-userNeedsToReauthenticate")
}
