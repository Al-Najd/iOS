//
//  ANPrayer.swift
//  
//
//  Created by Ahmed Ramy on 09/08/2022.
//

import Foundation
import Localization

public struct ANPrayer: Equatable {
    public let name: String
    public let raqaat: Int
    public let sunnah: [ANSunnah]
    public let afterAzkar: [ANAzkar]
    
}

public extension ANPrayer {
    static let fajr: ANPrayer = .init(
        name: L10n.fajr,
        raqaat: 2,
        sunnah: [.fajrSunnah],
        afterAzkar: .common
    )
    
    static let sunrise: ANPrayer = .init(
        name: "Sunrise",
        raqaat: 2,
        sunnah: [],
        afterAzkar: .common
    )
    
    static let dhuhr: ANPrayer = .init(
        name: L10n.duhr,
        raqaat: 4,
        sunnah: [.dhuhrBeforeSunnah, .dhuhrAfterSunnah, .dhuhrAfterMostahabSunnah],
        afterAzkar: .common
    )
    
    static let asr: ANPrayer = .init(
        name: L10n.aasr,
        raqaat: 4,
        sunnah: [],
        afterAzkar: .common
    )
    
    static let maghrib: ANPrayer = .init(
        name: L10n.maghrib,
        raqaat: 3,
        sunnah: [.maghribBeforeMostahabSunnah, .maghribAfterSunnah],
        afterAzkar: .common
    )
    
    static let isha: ANPrayer = .init(
        name: L10n.aishaa,
        raqaat: 4,
        sunnah: [.ishaaBeforeMostahabSunnah, .ishaaAfterSunnah],
        afterAzkar: .common
    )
}

public extension Array where Element == ANPrayer {
    static let faraaid: [ANPrayer] = [
        .fajr,
        .dhuhr,
        .asr,
        .maghrib,
        .isha
    ]
}

public struct ANSunnah: Identifiable, Equatable {
    public let id: UUID = .init()
    public let name: String
    public let raqaat: Int
    public let position: Position
    public let affirmation: Affirmation
    public let azkar: [ANAzkar]
}

public extension ANSunnah {
    enum Position: Equatable {
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
    enum Affirmation: Equatable {
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

public extension ANSunnah {
    static let fajrSunnah: ANSunnah = .init(
        name: L10n.fajr,
        raqaat: 2,
        position: .before,
        affirmation: .affirmed,
        azkar: []
    )
    
    static let dhuhrBeforeSunnah: ANSunnah = .init(
        name: L10n.duhr,
        raqaat: 4,
        position: .before,
        affirmation: .affirmed,
        azkar: []
    )
    
    static let dhuhrAfterSunnah: ANSunnah = .init(
        name: L10n.duhr,
        raqaat: 2,
        position: .after,
        affirmation: .affirmed,
        azkar: []
    )
    
    static let dhuhrAfterMostahabSunnah: ANSunnah = .init(
        name: L10n.duhr,
        raqaat: 2,
        position: .after,
        affirmation: .desirable,
        azkar: []
    )
    
    static let maghribBeforeMostahabSunnah: ANSunnah = .init(
        name: L10n.maghrib,
        raqaat: 2,
        position: .before,
        affirmation: .desirable,
        azkar: []
    )
    
    static let maghribAfterSunnah: ANSunnah = .init(
        name: L10n.maghrib,
        raqaat: 2,
        position: .after,
        affirmation: .affirmed,
        azkar: []
    )
    
    static let ishaaBeforeMostahabSunnah: ANSunnah = .init(
        name: L10n.aishaa,
        raqaat: 2,
        position: .before,
        affirmation: .desirable,
        azkar: []
    )
    
    static let ishaaAfterSunnah: ANSunnah = .init(
        name: L10n.aishaa,
        raqaat: 2,
        position: .after,
        affirmation: .affirmed,
        azkar: []
    )
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
    public let id: UUID = .init()
    public let name: String
    public let reward: String
    public let repetation: Int
}

extension Array where Element == ANAzkar {
    static let common: [ANAzkar] = [
        .init(
            name: L10n.estigphar,
            reward: .empty,
            repetation: 3
        )
    ]
}
