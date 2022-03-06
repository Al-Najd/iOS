//
//  SystemEnvironment.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 27/01/2022.
//

import Utils
import Business
import Foundation
import Entities
import ComposableCoreLocation
import PrayersClient

@dynamicMemberLookup
public struct CoreEnvironment<Environment> {
  public var environment: Environment
  public var cache: () -> (CacheManager)
  public var userDefaults: UserDefaultsClient
  public var locationManager: LocationManager
  public var mainQueue: AnySchedulerOf<DispatchQueue>
  public var prayersClient: PrayersClient
  public var coordinates: CLLocationCoordinate2D? = nil

  public subscript<Dependency>(
    dynamicMember keyPath: WritableKeyPath<Environment, Dependency>
  ) -> Dependency {
    get { self.environment[keyPath: keyPath] }
    set { self.environment[keyPath: keyPath] = newValue }
  }

  public static func live(_ environment: Environment) -> Self {
    Self(
      environment: environment,
      cache: {
        CacheManager(decoder: .init(), encoder: .init())
      },
      userDefaults: .live(),
      locationManager: .live,
      mainQueue: .main,
      prayersClient: .live
    )
  }
}

public extension CoreEnvironment {
  func getAzkarCategorized(
    _ date: Date
  ) -> [AzkarCategory: [RepeatableDeed]] {
    AzkarCategory
      .allCases
      .reduce(into: [AzkarCategory: [RepeatableDeed]]()) { dictionary, category in
        dictionary[category] = getAzkarFromCache(date, category) ?? category.defaultDeeds
      }
  }
  
  func getPrayersCategorized(
    _ date: Date
  ) -> [Deed.Categorized] {
    DeedCategory
      .allCases
      .map {
          Deed.Categorized.init(
            category: $0,
            deeds: getPrayersFromCache(date, $0) ?? $0.defaultDeeds
          )
      }
  }
  
  func getPrayersFromCache(
    _ date: Date,
    _ category: DeedCategory
  ) -> [Deed]? {
      cache().fetch([Deed].self, for: .prayers(date, category))
  }
  
  func getAzkarFromCache(
    _ date: Date,
    _ category: AzkarCategory
  ) -> [RepeatableDeed]? {
      cache().fetch([RepeatableDeed].self, for: .azkar(date, category))
  }
  
  func getPrayersRewardsFromCache(
    _ date: Date,
    _ category: DeedCategory
  ) -> [Deed]? {
      cache().fetch([Deed].self, for: .prayersRewards(date, category))
  }
  
  func getAzkarRewardsFromCache(
    _ date: Date,
    _ category: AzkarCategory
  ) -> [RepeatableDeed]? {
      cache().fetch([RepeatableDeed].self, for: .azkarRewards(date, category))
  }
}

public struct UserDefaultsClient {
    public var boolForKey: (String) -> Bool
    public var dataForKey: (String) -> Data?
    public var doubleForKey: (String) -> Double
    public var integerForKey: (String) -> Int
    public var remove: (String) -> Effect<Never, Never>
    public var setBool: (Bool, String) -> Effect<Never, Never>
    public var setData: (Data?, String) -> Effect<Never, Never>
    public var setDouble: (Double, String) -> Effect<Never, Never>
    public var setInteger: (Int, String) -> Effect<Never, Never>
    
    public var hasShownFirstLaunchOnboarding: Bool {
        self.boolForKey(StorageKey.didCompleteOnboarding.key)
    }
    
    public var isFontAccessible: Bool {
        self.boolForKey(StorageKey.enableAccessibilityFont.key)
    }
    
    public func setHasShownFirstLaunchOnboarding(_ bool: Bool) -> Effect<Never, Never> {
        self.setBool(bool, StorageKey.didCompleteOnboarding.key)
    }
    
    public func setFontAccessiblity(_ bool: Bool) -> Effect<Never, Never> {
        self.setBool(bool, StorageKey.enableAccessibilityFont.key)
    }
}

extension UserDefaultsClient {
    public static func live(
        userDefaults: UserDefaults = UserDefaults(suiteName: "com.nerdor.the-one")!
    ) -> Self {
        Self(
            boolForKey: userDefaults.bool(forKey:),
            dataForKey: userDefaults.data(forKey:),
            doubleForKey: userDefaults.double(forKey:),
            integerForKey: userDefaults.integer(forKey:),
            remove: { key in
                    .fireAndForget {
                        userDefaults.removeObject(forKey: key)
                    }
            },
            setBool: { value, key in
                    .fireAndForget {
                        userDefaults.set(value, forKey: key)
                    }
            },
            setData: { data, key in
                    .fireAndForget {
                        userDefaults.set(data, forKey: key)
                    }
            },
            setDouble: { value, key in
                    .fireAndForget {
                        userDefaults.set(value, forKey: key)
                    }
            },
            setInteger: { value, key in
                    .fireAndForget {
                        userDefaults.set(value, forKey: key)
                    }
            }
        )
    }
}

let hasShownFirstLaunchOnboardingKey = "hasShownFirstLaunchOnboardingKey"
let installationTimeKey = "installationTimeKey"
let multiplayerOpensCount = "multiplayerOpensCount"
