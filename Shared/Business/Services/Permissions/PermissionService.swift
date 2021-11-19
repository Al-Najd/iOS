//
//  PermissionService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 18/11/2021.
//

import SPPermissions
import SPPermissionsSiri
import SPPermissionsNotification
import SPPermissionsLocationWhenInUse
import SPPermissionsReminders

public enum ANPermission: CaseIterable {
  case siri
  case notifications
  case locationWhenInUse
  case reminders
}

extension ANPermission {
  func canUse() -> Bool {
    self.toSPPermission().authorized
  }
  
  func toSPPermission() -> SPPermissions.Permission {
    switch self {
      // TODO: [Future] Add More Types when Needed
    default:
      return .notification
    }
  }
}

public final class PermissionService {
  public static let main: PermissionService = PermissionService()
  
  /// Just gathering the needed for now
  let permissions: [ANPermission] = [
    .notifications
  ]
  
  var onHandle: RSHandler<Void>?
  
  func check(permission: ANPermission, handler: @escaping Callback<SPPermissionsList>, then: @escaping VoidCallback) {
    if permission.canUse() {
      then()
    } else {
      handler(SPPermissionsList(permissions: [permission.toSPPermission()], dataSource: nil, delegate: self))
      onHandle = { results in
        guard case .success = results else { return }
        then()
      }
    }
  }
}

extension PermissionService: SPPermissionsDelegate {
  public func didAllowPermission(_ permission: SPPermissions.Permission) {
    self.onHandle?(.success(()))
  }
  
  public func didDeniedPermission(_ permission: SPPermissions.Permission) {
    self.onHandle?(.failure(.noPermission))
  }
}
