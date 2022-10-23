//
//  ANPrayer.swift
//  
//
//  Created by Ahmed Ramy on 09/08/2022.
//

import Foundation
import Localization
import Assets
import Utils
import SwiftUI
import ComposableArchitecture

public struct ANPrayer: Identifiable, Equatable {
  public let id: Int
  public let name: String
  public let title: String
  public let subtitle: String
  public let raqaat: Int
	public let reward: String
  public var sunnah: IdentifiedArrayOf<ANSunnah>
  public var afterAzkar: IdentifiedArrayOf<ANAzkar>
  public var isDone: Bool = false
  
	public init(id: Int64, name: String, raqaat: Int, sunnah: IdentifiedArrayOf<ANSunnah>, afterAzkar: IdentifiedArrayOf<ANAzkar>, isDone: Bool = false, reward: String) {
    self.id = Int(id)
    self.name = name
    self.title = L10n.prayerTitle(name.localized)
    self.subtitle = L10n.raqaatCount(raqaat)
    self.raqaat = raqaat
    self.sunnah = sunnah
    self.afterAzkar = afterAzkar
    self.isDone = isDone
	  self.reward = reward
  }
}

public struct ANSunnah: Identifiable, Equatable {
  public let id: Int
  public let name: String
  public let raqaat: Int
  public let position: Position
  public let affirmation: Affirmation
	public let reward: String
  public let azkar: [ANAzkar]
  public var isDone: Bool = false
  
	public init(id: Int64, name: String, raqaat: Int, position: ANSunnah.Position, affirmation: ANSunnah.Affirmation, azkar: [ANAzkar], isDone: Bool = false, reward: String) {
    self.id = Int(id)
	  self.name = name.localized
    self.raqaat = raqaat
    self.position = position
    self.affirmation = affirmation
    self.azkar = azkar
    self.isDone = isDone
	  self.reward = reward
  }
}

public extension ANSunnah {
  enum Position: String, Equatable {
    case before
    case after
    
    public var text: String {
      switch self {
      case .before:
        return L10n.raqaatPositionBefore
      case .after:
        return L10n.raqaatPositionAfter
      }
    }
  }
  
  /// Meaning: سنة مؤكدة أم مستحبة
  enum Affirmation: String, Equatable {
    case affirmed
    case desirable
    
    public var text: String {
      switch self {
      case .affirmed:
        return L10n.sunnahAffirmed
      case .desirable:
        return L10n.sunnahDesired
      }
    }
  }
}

public struct ANNafila {
  public let name: String
  public let raqaat: Raqaat
}

public extension ANNafila {
  static let subh: ANNafila = .init(name: "Subh", raqaat: .defined(2))
  static let duha: ANNafila = .init(name: "Duha", raqaat: .atLeast(4))
  static let shaf: ANNafila = .init(name: "Shaf3", raqaat: .defined(2))
  static let watr: ANNafila = .init(name: "Watr", raqaat: .defined(1))
  static let qeyamAlLayf: ANNafila = .init(name: "", raqaat: .atLeast(2))
  
  enum Raqaat: Equatable {
    case defined(Int)
    case atLeast(Int)
    case open
  }
}

public struct ANAzkar: Identifiable, Equatable {
  public let id: Int
  public let name: String
  public let reward: String
  public let repetation: Int
  public var currentCount: Int
  public var isDone: Bool { currentCount == .zero }
  
  public init(id: Int64, name: String, reward: String, repetation: Int, currentCount: Int) {
    self.id = Int(id)
	  self.name = name.localized
	  self.reward = reward.localized
    self.repetation = repetation
    self.currentCount = currentCount
  }
}

public extension ANSunnah {
  var title: String {
    L10n.sunnahTitle(name, affirmation.text)
  }
  
  var subtitle: String {
    return L10n.sunnahSubtitle(name, position.text, L10n.raqaatCount(raqaat))
  }
}

extension ANPrayer: Changeable {}
extension ANSunnah: Changeable {}
extension ANAzkar: Changeable {}

extension ANPrayer {
  public var image: Image {
    switch name {
    case "fajr":
      return Asset.Prayers.Images.fajrImage.swiftUIImage
    case "duhr":
      return Asset.Prayers.Images.dhuhrImage.swiftUIImage
    case "aasr":
      return Asset.Prayers.Images.asrImage.swiftUIImage
    case "maghrib":
      return Asset.Prayers.Images.maghribImage.swiftUIImage
    case "aishaa":
      return Asset.Prayers.Images.ishaImage.swiftUIImage
    default:
      fatalError()
    }
  }
}
