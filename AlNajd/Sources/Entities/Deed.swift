//
//  Deed.swift
//  Deed
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import Foundation
import Utils
import Localization

public struct Deed: Identifiable, Codable, Equatable {
    public var id: UUID = .init()
    public var category: DeedCategory
    public var title: String
    public var isDone: Bool = false
    public var reward: Reward
}

public struct Reward: Identifiable, Codable, Equatable {
    public var id: UUID = .init()
    public var title: String
}

public enum DeedCategory: Identifiable, Codable, Equatable, Hashable, CaseIterable {
    case fard
    case sunnah
    case nafila
    
    public var id: String {
        return "\(self)"
    }
    
    public var title: String {
        switch self {
        case .fard:
            return "Faraaid".localized
        case .sunnah:
            return "Sunnah".localized
        case .nafila:
            return "Nafila".localized
        }
    }
    
    public var defaultDeeds: [Deed] {
        switch self {
        case .fard:
            return .faraaid
        case .sunnah:
            return .sunnah
        case .nafila:
            return .nafila
        }
    }
}

public enum AzkarCategory: Identifiable, Codable, CaseIterable {
    case sabah
    case masaa
    
    public var id: String {
        "\(self)"
    }
    
    public var title: String {
        switch self {
        case .sabah:
            return "Azkar Al-Sabah".localized
        case .masaa:
            return "Azkar Al-Masaa".localized
        }
    }
    
    public var defaultDeeds: [RepeatableDeed] {
        switch self {
        case .sabah:
            return .sabah
        case .masaa:
            return .masaa
        }
    }
}

// MARK: - Faraaid
public extension Deed {
    static let fajr: Deed = .init(
        category: .fard,
        title: "Fajr".localized,
        reward: .init(title: "If the Sunnah was better than all of that is good on life, what do you think the Fajr is?".localized)
    )
    
    static let duhr: Deed = .init(
        category: .fard,
        title: "Duhr".localized,
        reward: .init(title: "There are 25+ benefit in Duhr, the best? Getting closer to Allah!".localized)
    )
    
    static let aasr: Deed = .init(
        category: .fard,
        title: "Aasr".localized,
        reward: .init(title: "Now Repentence is easier, and so are Solutions to problems!".localized)
    )
    
    static let maghrib: Deed = .init(
        category: .fard,
        title: "Maghrib".localized,
        reward: .init(title: "Wealth Buffed, Dua and Wishes Buffed, Blessing Showered, That's what you've won with Al Maghrib".localized)
    )
    
    static let aishaa: Deed = .init(category: .fard, title: "Aishaa".localized, reward: .init(title: "Sleep and tranquility".localized))
}

// MARK: - Sunnah
public extension Deed {
    static let sunnatAlFajr: Deed = .init(
        category: .sunnah,
        title: "2 Raqaat Before Fajr".localized,
        reward: .init(title: "Richest Man of all who didn't pray!".localized)
    )
    
    static let sunnatAlDuhrBefore: Deed = .init(
        category: .sunnah,
        title: "4 Raqaat Before Duhr".localized,
        reward: .init(
            title: "Your Iman Grow further!".localized
        )
    )
    
    static let sunnatAlDuhrAfter: Deed = .init(
        category: .sunnah,
        title: "2 Raqaat After Duhr".localized,
        reward: .init(
            title: "Your Iman Grow further!".localized
        )
    )
    
    static let sunnatAlMaghrib: Deed = .init(
        category: .sunnah,
        title: "2 Raqaat After Al Maghrib".localized,
        reward: .init(
            title: "The Prophet SAW never left the Sunnah of Al Maghrib".localized
        )
    )
    
    static let sunnatAlAishaa: Deed = .init(
        category: .sunnah,
        title: "2 Raqaat After Al Aishaa".localized,
        reward: .init(
            title: "Other than being a Sunnah, it contribute towards being Qyam Layil".localized
        )
    )
}

// MARK: - Nawafil
public extension Deed {
    static let duha: Deed = .init(
        category: .nafila,
        title: "Duha".localized,
        reward: .init(
            title: "The Awabeen Prayer, Allah praise those who are Awabeen, and you get sadaqat on any deed you do!".localized
        )
    )
    
    static let qeyamAlLayl: Deed = .init(
        category: .nafila,
        title: "Qyam Al Layl".localized,
        reward: .init(
            title: "The Honor of Muslim, it's said that Angels pray to those who miss it for a day or two if they make a habit of it in case they are sick, and Angels prayers are blessed".localized
        )
    )
    
    static let wetr: Deed = .init(
        category: .nafila,
        title: "Wetr".localized,
        reward: .init(
            title: "Wetr when done with 7 Verses, is same as doing Qyam Al Layl".localized
        )
    )
}

public extension Array where Element == Deed {
    static let faraaid: [Deed] = [
        .fajr,
        .duhr,
        .aasr,
        .maghrib,
        .aishaa
    ]
    
    static let sunnah: [Deed] = [
        .sunnatAlFajr,
        .sunnatAlDuhrBefore,
        .sunnatAlDuhrAfter,
        .sunnatAlMaghrib,
        .sunnatAlAishaa
    ]
    
    static let nafila: [Deed] = [
        .duha,
        .qeyamAlLayl,
        .wetr
    ]
}
