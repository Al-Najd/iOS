//
//  RepeatableDeed.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 17/11/2021.
//

import Foundation

public struct RepeatableDeed: Identifiable, Codable, Equatable {
  public var id: UUID = .init()
  
  public let title: String
  public let numberOfRepeats: Int
  public var currentNumberOfRepeats: Int
  
  public let category: AzkarCategory
  public var reward: Reward
  
  public var isDone: Bool {
    currentNumberOfRepeats <= 0
  }
  
  public init(id: UUID = .init(), title: String, numberOfRepeats: Int, category: AzkarCategory, reward: Reward) {
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
        category: .sabah,
        reward: .init(title: $0.purpose)
      )
    }
  }()
  
  public static let masaa: [RepeatableDeed] = {
    Zekr.mainAzkar.filter { $0.category == .masaa }.map {
      return RepeatableDeed(
        title: $0.zekr,
        numberOfRepeats: $0.count,
        category: .masaa,
        reward: .init(title: $0.purpose)
      )
    }
  }()
}
