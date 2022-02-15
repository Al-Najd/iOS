//
//  ANPermission.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 15/02/2022.
//

import Foundation

public struct ANPermission: Identifiable, Equatable {
  public let id: String = UUID().uuidString
  public let title: String
  public let icon: String
  public let subtitles: String
  
  /// Description of why this permission is needed in points (fed through POEditor)
  public let needs: [String]
  public let status: Status
  public let type: `Type`
  
  public init(
    title: String,
    icon: String,
    subtitles: String,
    needs: [String],
    status: Status = .notDetermined,
    type: `Type` = .`internal`
  ) {
    self.title = title
    self.icon = icon
    self.subtitles = subtitles
    self.needs = needs
    self.status = status
    self.type = type
  }
}

public extension ANPermission {
  enum Status: Equatable {
    case notDetermined
    case given
    case denied
    case insufficient(reason: String)
  }
  
  enum `Type`: Equatable {
    case `internal`
    case iOS(url: String)
  }
}
