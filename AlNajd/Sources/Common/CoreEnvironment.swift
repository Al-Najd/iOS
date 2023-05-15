//
//  SystemEnvironment.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 27/01/2022.
//

import Business
import ComposableArchitecture
import ComposableCoreLocation
import Entities
import Foundation
import PrayersClient
import Utils

@dynamicMemberLookup
public struct CoreEnvironment<Environment> {
    public var environment: Environment
    public var cache: () -> (CacheManager)
    public var locationManager: LocationManager
    public var mainQueue: AnySchedulerOf<DispatchQueue>
    public var prayersClient: PrayersClient
    public var haptic: HapticFeedbackClient
    public var coordinates: CLLocationCoordinate2D? = nil

    public subscript<Dependency>(
        dynamicMember keyPath: WritableKeyPath<Environment, Dependency>)
        -> Dependency {
        get { self.environment[keyPath: keyPath] }
        set { self.environment[keyPath: keyPath] = newValue }
    }

    public static func live(_ environment: Environment) -> Self {
        Self(
            environment: environment,
            cache: {
                CacheManager(decoder: .init(), encoder: .init())
            },
            locationManager: .live,
            mainQueue: .main,
            prayersClient: .live,
            haptic: .init())
    }
}


extension CacheManager: DependencyKey {
    public static let liveValue = CacheManager()
}

public extension DependencyValues {
    var cache: CacheManager {
        get { self[CacheManager.self] }
        set { self[CacheManager.self] = newValue }
    }
}
