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

public extension OAnimation {
  static let splash: OAnimation = .init(name: "splash")
}

public extension StorageKey {
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

public extension StorageKey {
  static let standard: StandardEntity = .main
  
  struct StandardEntity {
    static let main: StandardEntity = .init()
    let prayers: (_ category: DeedCategory) -> StorageKey = {
      .init(
        key: "\($0.id)-prayer",
        suitableStorage: .userDefaults
      )
    }
    
    let azkar: (_ category: AzkarCategory) -> StorageKey = {
      .init(
        key: "\($0.id)-azkar",
        suitableStorage: .userDefaults
      )
    }
  }
}
