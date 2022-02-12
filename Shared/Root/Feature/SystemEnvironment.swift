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
struct SystemEnvironment<Environment> {
  var environment: Environment
  var cache: () -> (CacheManager)
  var locationManager: () -> LocationManager

  subscript<Dependency>(
    dynamicMember keyPath: WritableKeyPath<Environment, Dependency>
  ) -> Dependency {
    get { self.environment[keyPath: keyPath] }
    set { self.environment[keyPath: keyPath] = newValue }
  }

  static func live(_ environment: Environment) -> Self {
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

func getAzkarCategorized(
  _ cache: CacheManager,
  _ date: Date
) -> [AzkarCategory: [RepeatableDeed]] {
  AzkarCategory
    .allCases
    .reduce(into: [AzkarCategory: [RepeatableDeed]]()) { dictionary, category in
    dictionary[category] = getAzkarFromCache(cache, date, category) ?? category.defaultDeeds
  }
}

func getPrayersCategorized(
  _ cache: CacheManager,
  _ date: Date
) -> [DeedCategory: [Deed]] {
  DeedCategory
    .allCases
    .reduce(into: [DeedCategory: [Deed]]()) { dictionary, category in
      dictionary[category] = getPrayersFromCache(cache, date, category) ?? category.defaultDeeds
  }
}

func getPrayersFromCache(
  _ cache: CacheManager,
  _ date: Date,
  _ category: DeedCategory
) -> [Deed]? {
  cache.fetch([Deed].self, for: .prayers(date, category))
}

func getAzkarFromCache(
  _ cache: CacheManager,
  _ date: Date,
  _ category: AzkarCategory
) -> [RepeatableDeed]? {
  cache.fetch([RepeatableDeed].self, for: .azkar(date, category))
}

func getPrayersRewardsFromCache(
  _ cache: CacheManager,
  _ date: Date,
  _ category: DeedCategory
) -> [Deed]? {
  cache.fetch([Deed].self, for: .prayersRewards(date, category))
}

func getAzkarRewardsFromCache(
  _ cache: CacheManager,
  _ date: Date,
  _ category: AzkarCategory
) -> [RepeatableDeed]? {
  cache.fetch([RepeatableDeed].self, for: .azkarRewards(date, category))
}
