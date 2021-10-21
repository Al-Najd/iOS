//
//  Deed.swift
//  Deed
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import Foundation

struct Deed: Identifiable {
  var id: UUID = .init()
  var category: DeedCategory
  var title: String
  var isDone: Bool = false
//  var startTime: Date
//  var endTime: Date
  var reward: Reward
}

struct Reward: Identifiable {
  var id: UUID = .init()
  var title: String
}

enum DeedCategory {
  case fard
  case sunnah
  case nafila
}

extension Array where Element == Deed {
  static let faraaid: [Deed] = [
    .init(
      category: .fard,
      title: "Fajr",
      reward: .init(title: "If the Sunnah was better than all of that is good on life, what do you think the Fajr is?")),
    .init(category: .fard, title: "Duhr", reward: .init(title: "There are 25+ benefit in Duhr, the best? Getting closer to Allah!")),
    .init(
      category: .fard,
      title: "Aasr",
      reward: .init(title: "Now Repentence is easier, and so are Solutions to problems!")
    ),
    .init(category: .fard, title: "Maghrib", reward: .init(title: "Wealth Buffed, Dua and Wishes Buffed, Blessing Showered, That's what you've won with Al Maghrib")),
    .init(category: .fard, title: "Aishaa", reward: .init(title: "Sleep and tranquility"))
  ]
  
  static let sunnah: [Deed] = [
    .init(
      category: .sunnah,
      title: "2 Raqaat Before Fajr",
      reward: .init(
        title: "Richest Man of all who didn't pray!"
      )
    ),
    .init(
      category: .sunnah,
      title: "4 Raqaat Before Duhr",
      reward: .init(
        title: "Your Iman Grow further!"
      )
    ),
    .init(
      category: .sunnah,
      title: "4 Raqaat After Duhr",
      reward: .init(
        title: "Your Iman Grow further!"
      )
    ),
    .init(
      category: .sunnah,
      title: "2 Raqaat After Al Maghrib",
      reward: .init(
        title: "The Prophet SAW never left the Sunnah of Al Maghrib"
      )
    )
  ]
  
  static let nafila: [Deed] = [
    .init(
      category: .nafila,
      title: "Duha",
      reward: .init(
        title: "The Awabeen Prayer, Allah praise those who are Awabeen, and you get sadaqat on any deed you do!"
      )
    ),
    .init(
      category: .nafila,
      title: "Qyam Al Layl",
      reward: .init(
        title: "The Honor of Muslim, it's said that Angels pray to those who miss it for a day or two if they make a habit of it in case they are sick, and Angels prayers are blessed"
      )
    )
  ]
}
