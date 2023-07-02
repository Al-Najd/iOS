//
//  ANSettingsModifier.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 15/02/2022.
//

import Foundation


public struct ANSettingsModifier: Identifiable, Equatable {
    public let id: String = UUID().uuidString
    public let title: String
    public let icon: String
    public let subtitles: String

    /// Is specific to the app or general settings in the iOS
    public let isInternal: Bool

    public init(
        title: String,
        icon: String,
        subtitles: String,
        isInternal: Bool) {
        self.title = title
        self.icon = icon
        self.subtitles = subtitles
        self.isInternal = isInternal
    }
}
