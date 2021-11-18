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
  var numberOfRepeats: Int
  
  let category: DeedCategory
  var reward: Reward
  
  var isDone: Bool {
    numberOfRepeats <= 0
  }
}

extension Array where Element == RepeatableDeed {
  public static let azkar: [RepeatableDeed] = sabah + masaa
  
  public static let sabah: [RepeatableDeed] = [
    .init(
      title: "Korsi",
      numberOfRepeats: 1,
      category: .azkar(.sabah),
      reward: .init(title: "??")
    ),
    .init(
      title: "RadytoBellah".localized,
      numberOfRepeats: 3,
      category: .azkar(.sabah),
      reward: .init(
        title: "Allah Must Satisfy you".localized
      )
    ),
  ]
  
  public static let masaa: [RepeatableDeed] = [
    .init(
      title: "Korsi",
      numberOfRepeats: 1,
      category: .azkar(.sabah),
      reward: .init(title: "??")
    ),
    .init(
      title: "RadytoBellah".localized,
      numberOfRepeats: 3,
      category: .azkar(.masaa),
      reward: .init(
        title: "Allah Must Satisfy you".localized
      )
    )
  ]
}
