//
//  ResourcesAccess.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 23/01/2022.
//

import Foundation
import Animations
import Business
import Entities

extension OAnimation {
  static let splash: OAnimation = .init(name: "splash")
}

extension StorageKey {
  static let prayers: (_ date: Date, _ category: DeedCategory) -> StorageKey = {
    .init(
      key: "\($0.day)-\($0.month)-\($0.year)-\($1)-prayers",
      suitableStorage: .userDefaults
    )
  }
  
  static let azkar: (_ date: Date, _ category: AzkarCategory) -> StorageKey = {
    .init(
      key: "\($0.day)-\($0.month)-\($0.year)-\($1)-azkar",
      suitableStorage: .userDefaults
    )
  }
  
  static let prayersRewards: (_ date: Date, _ category: DeedCategory) -> StorageKey = {
    .init(
      key: "\($0.day)-\($0.month)-\($0.year)-\($1)-prayers-rewards",
      suitableStorage: .userDefaults
    )
  }
  
  static let azkarRewards: (_ date: Date, _ category: AzkarCategory) -> StorageKey = {
    .init(
      key: "\($0.day)-\($0.month)-\($0.year)-\($1)-azkar-rewards",
      suitableStorage: .userDefaults
    )
  }
}