//
//  OError.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 13/09/2021.
//

public struct OError: Error, Codable {
  public var text: String
  public var loggable: Bool = true
  public var presentable: Bool = true
  
  public init(text: String, loggable: Bool = true, presentable: Bool = true) {
      self.text = text
      self.loggable = loggable
      self.presentable = presentable
  }
}

public extension String {
  func asOError() -> OError {
    .init(text: self)
  }
}

public extension OError {
  static var silentError: OError {
    .init(text: "", loggable: false, presentable: false)
  }
  
  static var silentLoggableError: OError {
    .init(text: "", loggable: true, presentable: false)
  }
  
  static var somethingWentWrong: OError {
    "Oops, something went wrong".asOError()
  }
  
  static var requestCancelled: OError {
    .silentError
  }
  
  // TODO: - [Future] Localize -
  static var refreshTokenExpired: OError {
    "You must log in again...".asOError()
  }
  
  // TODO: - [Future] Localize -
  static var noNetworkOrTooWeak: OError {
    "We can't detect a network, either because it's too weak or it's non-existent, most probably the signal?".asOError()
  }
  
  static var tokenExpired: OError {
    .silentLoggableError
  }
  
  static var noPermission: OError {
    "Sorry but this feature is unavailble without a permission 🙁".asOError()
  }
}
