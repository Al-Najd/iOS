//
//  Deed.swift
//  Deed
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import Foundation
import Localization
import Utils

// MARK: - Deed

public struct Deed: Identifiable, Codable, Equatable {
    public var id: UUID = .init()
    public var category: DeedCategory
    public var title: String
    public var isDone = false
    public var reward: Reward
}

// MARK: Deed.Categorized

public extension Deed {
    struct Categorized: Codable, Equatable {
        public let category: DeedCategory
        public var deeds: [Deed]

        public init(category: DeedCategory, deeds: [Deed]) {
            self.category = category
            self.deeds = deeds
        }
    }
}

// MARK: - Deed.Categorized + Changeable

extension Deed.Categorized: Changeable { }

public extension Deed.Categorized {
    static let faraaid: Deed.Categorized = .init(category: .fard, deeds: .faraaid)
    static let sunnah: Deed.Categorized = .init(category: .sunnah, deeds: .sunnah)
    static let nafila: Deed.Categorized = .init(category: .nafila, deeds: .nafila)
}

public extension Sequence where Element == Deed.Categorized {
    var faraaid: Deed.Categorized? {
        first(where: { $0.category == .fard })
    }

    var sunnah: Deed.Categorized? {
        first(where: { $0.category == .sunnah })
    }

    var nafila: Deed.Categorized? {
        first(where: { $0.category == .nafila })
    }
}

// MARK: - Reward

public struct Reward: Identifiable, Codable, Equatable {
    public var id: UUID = .init()
    public var title: String
}

// MARK: - DeedCategory

public enum DeedCategory: Identifiable, Codable, Equatable, Hashable, CaseIterable {
    case fard
    case sunnah
    case nafila

    public var sortWeight: Int {
        switch self {
        case .fard:
            return 3
        case .sunnah:
            return 2
        case .nafila:
            return 1
        }
    }

    public var id: String {
        "\(self)"
    }

    public var title: String {
        switch self {
        case .fard:
            return "Faraaid"
        case .sunnah:
            return "Sunnah"
        case .nafila:
            return "Nafila"
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

// MARK: - AzkarCategory

public enum AzkarCategory: Identifiable, Codable, Equatable, Hashable, CaseIterable {
    case sabah
    case masaa

    public var id: String {
        "\(self)"
    }

    public var title: String {
        switch self {
        case .sabah:
            return "Azkar Al-Sabah"
        case .masaa:
            return "Azkar Al-Masaa"
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
        title: "Fajr",
        reward: .init(title: "If the Sunnah was better than all of that is good on life, what do you think the Fajr is?"))

    static let duhr: Deed = .init(
        category: .fard,
        title: "Duhr",
        reward: .init(title: "There are 25+ benefit in Duhr, the best? Getting closer to Allah!"))

    static let aasr: Deed = .init(
        category: .fard,
        title: "Aasr",
        reward: .init(title: "Now Repentence is easier, and so are Solutions to problems!"))

    static let maghrib: Deed = .init(
        category: .fard,
        title: "Maghrib",
        reward: .init(title: "Wealth Buffed, Dua and Wishes Buffed, Blessing Showered, That's what you've won with Al Maghrib"))

    static let aishaa: Deed = .init(category: .fard, title: "Aishaa", reward: .init(title: "Sleep and tranquility"))
}

// MARK: - Sunnah

public extension Deed {
    static let sunnatAlFajr: Deed = .init(
        category: .sunnah,
        title: "2 Raqaat Before Fajr",
        reward: .init(title: "Richest Man of all who didn't pray!"))

    static let sunnatAlDuhrBefore: Deed = .init(
        category: .sunnah,
        title: "4 Raqaat Before Duhr",
        reward: .init(
            title: "Your Iman Grow further!"))

    static let sunnatAlDuhrAfter: Deed = .init(
        category: .sunnah,
        title: "2 Raqaat After Duhr",
        reward: .init(
            title: "Your Iman Grow further!"))

    static let sunnatAlMaghrib: Deed = .init(
        category: .sunnah,
        title: "2 Raqaat After Al Maghrib",
        reward: .init(
            title: "The Prophet SAW never left the Sunnah of Al Maghrib"))

    static let sunnatAlAishaa: Deed = .init(
        category: .sunnah,
        title: "2 Raqaat After Al Aishaa",
        reward: .init(
            title: "Other than being a Sunnah, it contribute towards being Qyam Layil"))
}

// MARK: - Nawafil

public extension Deed {
    static let duha: Deed = .init(
        category: .nafila,
        title: "Duha",
        reward: .init(
            title: "The Awabeen Prayer, Allah praise those who are Awabeen, and you get sadaqat on any deed you do!"))

    static let qeyamAlLayl: Deed = .init(
        category: .nafila,
        title: "Qyam Al Layl",
        reward: .init(
            title: "The Honor of Muslim, it's said that Angels pray to those who miss it for a day or two if they make a habit of it in case they are sick, and Angels prayers are blessed"))

    static let wetr: Deed = .init(
        category: .nafila,
        title: "Wetr",
        reward: .init(
            title: "Wetr when done with 7 Verses, is same as doing Qyam Al Layl"))
}

public extension Array where Element == Deed {
    static let faraaid: [Deed] = [
        .fajr,
        .duhr,
        .aasr,
        .maghrib,
        .aishaa,
    ]

    static let sunnah: [Deed] = [
        .sunnatAlFajr,
        .sunnatAlDuhrBefore,
        .sunnatAlDuhrAfter,
        .sunnatAlMaghrib,
        .sunnatAlAishaa,
    ]

    static let nafila: [Deed] = [
        .duha,
        .qeyamAlLayl,
        .wetr,
    ]
}
