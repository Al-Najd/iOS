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
  public let isEnabled: Bool
  public let url: String?
  
  public init(title: String, icon: String, subtitles: String, isEnabled: Bool, url: String? = nil) {
    self.title = title
    self.icon = icon
    self.subtitles = subtitles
    self.isEnabled = isEnabled
    self.url = url
  }
}
