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

@dynamicMemberLookup
public struct CoreEnvironment<Environment> {
  public var environment: Environment
  public var cache: () -> (CacheManager)
  public var locationManager: () -> LocationManager

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
      locationManager: {
        .live
      }
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
