//
//  ReportPlugin.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import UIKit.UIApplication

import Foundation
import Pulse
import Logging

struct ReportPlugin {}

extension ReportPlugin: AppPlugin {
  func setup() {
      setupPulse()
      setupSentry()
      LoggersManager.info(message: "Loggers Woke up")
  }

  private func setupPulse() {
      LoggingSystem.bootstrap(PersistentLogHandler.init)
      URLSessionProxyDelegate.enableAutomaticRegistration()
  }

  private func setupSentry() {
      SentryService.setup()
  }
}
