//
//  ReportPlugin.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 23/10/2021.
//

import UIKit.UIApplication

public struct ReportPlugin {
  var services: [RunnableService] = [
    LogService.main
  ]
}

extension ReportPlugin: AppPlugin {
  public func setup() {
    services.forEach { $0.start() }
  }
}
