//
//  RepeatableDeed.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 17/11/2021.
//

import Foundation

public struct RepeatableDeed: Identifiable, Codable {
  public var id: UUID = .init()
  
  let title: String
  let numberOfRepeats: Int
  var currentNumberOfRepeats: Int
  
  let category: DeedCategory
  var reward: Reward
  
  var isDone: Bool {
    currentNumberOfRepeats <= 0
  }
  
  init(id: UUID = .init(), title: String, numberOfRepeats: Int, category: DeedCategory, reward: Reward) {
    self.id = id
    self.title = title
    self.numberOfRepeats = numberOfRepeats
    self.currentNumberOfRepeats = numberOfRepeats
    self.category = category
    self.reward = reward
  }
}

extension Array where Element == RepeatableDeed {
  public static let azkar: [RepeatableDeed] = sabah + masaa
  
  public static var sabah: [RepeatableDeed] = {
    Zekr.mainAzkar.filter { $0.category == .sabah }.map {
      return RepeatableDeed(
        title: $0.zekr,
        numberOfRepeats: $0.count,
        category: .azkar(.sabah),
        reward: .init(title: $0.purpose)
      )
    }
  }()
  
  public static let masaa: [RepeatableDeed] = {
    Zekr.mainAzkar.filter { $0.category == .masaa }.map {
      return RepeatableDeed(
        title: $0.zekr,
        numberOfRepeats: $0.count,
        category: .azkar(.masaa),
        reward: .init(title: $0.purpose)
      )
    }
  }()
}
