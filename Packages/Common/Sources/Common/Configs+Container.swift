//
//  File.swift
//
//
//  Created by Ahmed Ramy on 05/04/2023.
//

import Configs
import Factory
import Foundation

// MARK: - Services
public extension Container {
    var loader: Factory<LoadingViewProtocol> { self { LoadingView() }.shared }
    var lifecycle: Factory<LifecycleObserverServiceProtocol> { self { LifecycleObserverService() }.shared }
}

// MARK: - Configs
public extension Container {
    var uiConfigs: Factory<UIConfigurable> { self { UIConfig() }.singleton }
}
