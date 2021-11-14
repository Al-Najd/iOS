//
//  LogService.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 22/10/2021.
//

import Pulse
import Logging

public protocol Service { }

public protocol RunnableService: Service {
  func start()
}

public final class LogService: RunnableService {
  public static let main: LogService = .init()
  public func start() {
    LoggingSystem.bootstrap(PersistentLogHandler.init)
    SentryService.main.start()
    LoggersManager.info("Loggers Woke Up!")
  }
}

public protocol LogEngine {
  func info(message: String)
  func warn(message: String)
  func error(message: String)
}

public enum LogTag: String {
  case `internal` = "[Internal]"
  case firebase = "[Firebase]"
  case realm = "[Realm]"
  case network = "[Network]"
  case imageDownload = "[Image Download]"
}

public struct LoggersManager {
  private static var engines: [LogEngine] {
    [
      PulseLogger.main,
      SystemLogger.main,
      SentryService.main.logEngine
    ]
      .compactMap { $0 }
  }
  
  public static func info(_ message: String) {
    engines.forEach { $0.info(message: message) }
  }
  
  public static func warn(_ message: String) {
    engines.forEach { $0.warn(message: message) }
  }
  
  public static func error(_ message: String) {
    engines.forEach { $0.error(message: message) }
  }
}

public extension String {
  func tagWith(_ tag: LogTag) -> String {
    ""
//    self.withPrefix("[\(tag.rawValue)] ")
  }
}

public final class SystemLogger: LogEngine {
  public static let main: SystemLogger = .init()
  private init() { }
  
  public func info(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
  
  public func warn(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
  
  public func error(message: String) {
    #if DEBUG
    print(message)
    #endif
  }
}
