//
//  CorePlugin.swift
//  The One
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import UIKit.UIApplication

public struct CorePlugin: AppPlugin {
  public func setup() {
    setupServiceLocator()
  }
}

private extension CorePlugin {
  func setupServiceLocator() {
    ServiceLocator.shared = ServiceLocator()
  }
}
