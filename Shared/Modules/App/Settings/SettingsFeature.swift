//
//  SettingsFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 02/02/2022.
//

import Foundation

struct SettingsState: Equatable {
  let permissions: [OPermission: OPermissionStatus] = [
    .location: .notDetermined
  ]
}

enum OPermission: Equatable {
  case location
  
  var title: String {
    switch self {
    case .location:
      return "Location".localized
    }
  }
  
  var icon: String {
    switch self {
    case .location:
      return "location.circle.fill"
    }
  }
}

enum OPermissionStatus: Equatable {
  case notDetermined
  case given
  case denied
  case insufficient(reason: String)
}
