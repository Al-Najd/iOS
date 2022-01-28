//
//  Deed.swift
//  Deed
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import Foundation
import Utils

struct Deed: Identifiable, Codable, Equatable {
  var id: UUID = .init()
  var category: DeedCategory
  var title: String
  var isDone: Bool = false
  var reward: Reward
}

struct Reward: Identifiable, Codable, Equatable {
  var id: UUID = .init()
  var title: String
}

enum DeedCategory: Identifiable, Codable, Equatable, Hashable, CaseIterable {
  case fard
  case sunnah
  case nafila
  
  var id: String {
    return "\(self)"
  }
  
  var title: String {
    switch self {
    case .fard:
      return "Faraaid".localized
    case .sunnah:
      return "Sunnah".localized
    case .nafila:
      return "Nafila".localized
    }
  }
}

enum AzkarCategory: Identifiable, Codable, CaseIterable {
  case sabah
  case masaa
  
  var id: String {
    "\(self)"
  }
  
  var title: String {
    switch self {
    case .sabah:
      return "Azkar Al-Sabah".localized
    case .masaa:
      return "Azkar Al-Masaa".localized
    }
  }
}

extension Array where Element == Deed {
  static let faraaid: [Deed] = [
    .init(
      category: .fard,
      title: "Fajr".localized,
      reward: .init(title: "If the Sunnah was better than all of that is good on life, what do you think the Fajr is?".localized)),
    .init(category: .fard, title: "Duhr".localized, reward: .init(title: "There are 25+ benefit in Duhr, the best? Getting closer to Allah!".localized)),
    .init(
      category: .fard,
      title: "Aasr".localized,
      reward: .init(title: "Now Repentence is easier, and so are Solutions to problems!".localized)
    ),
    .init(category: .fard, title: "Maghrib".localized, reward: .init(title: "Wealth Buffed, Dua and Wishes Buffed, Blessing Showered, That's what you've won with Al Maghrib".localized)),
    .init(category: .fard, title: "Aishaa".localized, reward: .init(title: "Sleep and tranquility".localized))
  ]
  
  static let sunnah: [Deed] = [
    .init(
      category: .sunnah,
      title: "2 Raqaat Before Fajr".localized,
      reward: .init(
        title: "Richest Man of all who didn't pray!".localized
      )
    ),
    .init(
      category: .sunnah,
      title: "4 Raqaat Before Duhr".localized,
      reward: .init(
        title: "Your Iman Grow further!".localized
      )
    ),
    .init(
      category: .sunnah,
      title: "4 Raqaat After Duhr".localized,
      reward: .init(
        title: "Your Iman Grow further!".localized
      )
    ),
    .init(
      category: .sunnah,
      title: "2 Raqaat After Al Maghrib".localized,
      reward: .init(
        title: "The Prophet SAW never left the Sunnah of Al Maghrib".localized
      )
    )
  ]
  
  static let nafila: [Deed] = [
    .init(
      category: .nafila,
      title: "Duha".localized,
      reward: .init(
        title: "The Awabeen Prayer, Allah praise those who are Awabeen, and you get sadaqat on any deed you do!".localized
      )
    ),
    .init(
      category: .nafila,
      title: "Qyam Al Layl".localized,
      reward: .init(
        title: "The Honor of Muslim, it's said that Angels pray to those who miss it for a day or two if they make a habit of it in case they are sick, and Angels prayers are blessed".localized
      )
    )
  ]
}
