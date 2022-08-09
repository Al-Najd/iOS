//
//  ANPrayer.swift
//  
//
//  Created by Ahmed Ramy on 09/08/2022.
//

import Foundation

public struct ANPrayer: Equatable {
    public let name: String
    public let raqaat: Int
    public let sunnah: [ANSunnah]
    public let afterAzkar: [NAzkar]
    
}

public extension ANPrayer {
    static let fajr: ANPrayer = .init(name: "Fajr", raqaat: 2, sunnah: [.fajrSunnah], afterAzkar: [])
    static let sunrise: ANPrayer = .init(name: "Sunrise", raqaat: 2, sunnah: [], afterAzkar: [])
    static let dhuhr: ANPrayer = .init(name: "Dhuhr", raqaat: 4, sunnah: [.dhuhrBeforeSunnah, .dhuhrAfterSunnah], afterAzkar: [])
    static let asr: ANPrayer = .init(name: "Asr", raqaat: 4, sunnah: [], afterAzkar: [])
    static let maghrib: ANPrayer = .init(name: "Maghrib", raqaat: 3, sunnah: [], afterAzkar: [])
    static let isha: ANPrayer = .init(name: "Isha", raqaat: 4, sunnah: [], afterAzkar: [])
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

public struct ANSunnah: Equatable {
    public let name: String
    public let raqaat: Int
    public let position: Position
    public let affirmation: Affirmation
    public let azkar: [NAzkar]
}

public extension ANSunnah {
    enum Position: Equatable {
        case before
        case after
    }
    
    /// Meaning: سنة مؤكدة أم مستحبة
    enum Affirmation: Equatable {
        case affirmed
        case desirable
        case fake
    }
}

public extension ANSunnah {
    static let fajrSunnah: ANSunnah = .init(
        name: "Fajr",
        raqaat: 2,
        position: .before,
        affirmation: .affirmed,
        azkar: []
    )
    
    static let dhuhrBeforeSunnah: ANSunnah = .init(
        name: "Duhr-Before",
        raqaat: 4,
        position: .before,
        affirmation: .affirmed,
        azkar: []
    )
    
    static let dhuhrAfterSunnah: ANSunnah = .init(
        name: "Duhr-After",
        raqaat: 2,
        position: .after,
        affirmation: .affirmed,
        azkar: []
    )
    
    static let dhuhrAfterMostahabSunnah: ANSunnah = .init(
        name: "Duhr-After-Mostahab",
        raqaat: 2,
        position: .after,
        affirmation: .desirable,
        azkar: []
    )
    
    static let maghribBeforeMostahabSunnah: ANSunnah = .init(
        name: "Maghrib-Before-Mostahab",
        raqaat: 2,
        position: .before,
        affirmation: .desirable,
        azkar: []
    )
    
    static let maghribAfterSunnah: ANSunnah = .init(
        name: "Maghrib-After",
        raqaat: 2,
        position: .after,
        affirmation: .affirmed,
        azkar: []
    )
    
    static let ishaaBeforeMostahabSunnah: ANSunnah = .init(
        name: "Isha-Before-Mostahab",
        raqaat: 2,
        position: .before,
        affirmation: .desirable,
        azkar: []
    )
    
    static let ishaaAfterSunnah: ANSunnah = .init(
        name: "Isha-After",
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

public struct NAzkar: Equatable {
    public let name: String
    public let reward: String
}
