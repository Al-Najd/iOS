//
//  PulseService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import Pulse
import Logging
import Foundation

public final class PulseService {
  public static let main: PulseService = .init()
  
  public func setup(sessionDelegate: URLSessionDelegate) -> URLSession {
    let proxyDelegate = URLSessionProxyDelegate(delegate: sessionDelegate)
    return URLSession(configuration: .default, delegate: proxyDelegate, delegateQueue: nil)
  }
}

public final class PulseLogger: LogEngine {
  public static let main: PulseLogger = .init()
  
  private let logger = Logger(label: "com.yourcompany.yourapp")
  private init() { }
  
  public func info(message: String) {
    #if DEBUG
    logger.info(Logger.Message(stringLiteral: message))
    #endif
  }
  
  public func warn(message: String) {
    #if DEBUG
    logger.warning(Logger.Message(stringLiteral: message))
    #endif
  }
  
  public func error(message: String) {
    #if DEBUG
    logger.error(Logger.Message(stringLiteral: message))
    #endif
  }
}
