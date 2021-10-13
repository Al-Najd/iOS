//
//  ServiceLocator.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 29/08/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import SwiftUI

var app = ServiceLocator.shared.app

/// Basic Dependency Container pattern called ServiceLocator, a basic Singleton which allows easy access to dependency of the system or services
///
/// Decision Log behind
///
/// ServiceLocator acts as a simple dependency container without any fanciness until we face a heavy usage for threading, in this
/// case, we can explore our options from either using a dedicated dependency container pattern, or we can apply locks
/// for now, we are using
///  ```
///  safeSync { (Async Code goes here) }
///  ```
/// Behind the scenes, this checks if the current thread is main, if not, it switches to it and executes the async code
/// 
struct ServiceLocator {
  static var shared: ServiceLocator!
  
  @State var app: AppService = AppService()
}
