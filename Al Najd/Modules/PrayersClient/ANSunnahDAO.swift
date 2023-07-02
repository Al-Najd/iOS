//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/03/2023.
//


import Foundation
import GRDB


// MARK: - ANSunnahDAO

public struct ANSunnahDAO {
    public var id: Int64?
    public var name: String
    public var isDone: Bool
    public var raqaat: Int
    public var position: Position
    public var affirmation: Affirmation
    public var prayerId: Int64
    public var reward: String
}

public extension ANSunnahDAO {
    enum Affirmation: Int, Codable, DatabaseValueConvertible {
        case affirmed
        case desirable
    }

    enum Position: Int, Codable, DatabaseValueConvertible {
        case before
        case after
    }
}

extension ANSunnahDAO {
    func toDomainModel() -> Sunnah {
        .init(
            id: id!,
            name: name,
            raqaat: raqaat,
            position: position.toDomainModel(),
            affirmation: affirmation.toDomainModel(),
            azkar: [],
            isDone: isDone,
            reward: reward)
    }
}

extension ANSunnahDAO.Position {
    func toDomainModel() -> Sunnah.Position {
        switch self {
        case .before: return .before
        case .after: return .after
        }
    }
}

extension ANSunnahDAO.Affirmation {
    func toDomainModel() -> Sunnah.Affirmation {
        switch self {
        case .affirmed: return .affirmed
        case .desirable: return .desirable
        }
    }
}

// MARK: - ANSunnahDAO + Codable, FetchableRecord, MutablePersistableRecord

extension ANSunnahDAO: Codable, FetchableRecord, MutablePersistableRecord { }

// MARK: - ANSunnahDAO + TableRecord, EncodableRecord

extension ANSunnahDAO: TableRecord, EncodableRecord {
    static let prayer = belongsTo(ANPrayerDAO.self)
    static let day = hasOne(DayDAO.self, through: prayer, using: ANPrayerDAO.day)

    public static var databaseTableName = "sunnah"

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let isDone = Column(CodingKeys.isDone)
        static let raqaat = Column(CodingKeys.raqaat)
        static let position = Column(CodingKeys.position)
        static let affirmation = Column(CodingKeys.affirmation)
    }

    enum Queries {
        static var fajr: QueryInterfaceRequest<ANSunnahDAO> {
            ANSunnahDAO.filter(Columns.name == "fajr")
        }
    }

    var prayer: QueryInterfaceRequest<ANPrayerDAO> {
        request(for: Self.prayer)
    }

    var day: QueryInterfaceRequest<DayDAO> {
        request(for: Self.day)
    }
}

// MARK: - Seedings
extension ANSunnahDAO {
    static let fajr: (Int64) -> ANSunnahDAO = {
        .init(
            name: "fajr",
            isDone: false,
            raqaat: 2,
            position: .before,
            affirmation: .affirmed,
            prayerId: $0,
            reward: "fajr_sunnah_reward")
    }

    static let dhuhr: (Int64) -> [ANSunnahDAO] = {
        [
            .init(
                name: "duhr",
                isDone: false,
                raqaat: 4,
                position: .before,
                affirmation: .affirmed,
                prayerId: $0,
                reward: "duhr_sunnah_reward"),
            .init(
                name: "duhr",
                isDone: false,
                raqaat: 2,
                position: .after,
                affirmation: .affirmed,
                prayerId: $0,
                reward: "duhr_sunnah_reward"),
            .init(
                name: "duhr",
                isDone: false,
                raqaat: 2,
                position: .after,
                affirmation: .desirable,
                prayerId: $0,
                reward: "duhr_sunnah_reward"),
        ]
    }

    static let maghrib: (Int64) -> [ANSunnahDAO] = {
        [
            .init(
                name: "maghrib",
                isDone: false,
                raqaat: 2,
                position: .before,
                affirmation: .desirable,
                prayerId: $0,
                reward: "maghrib_sunnah_reward"),
            .init(
                name: "maghrib",
                isDone: false,
                raqaat: 2,
                position: .after,
                affirmation: .affirmed,
                prayerId: $0,
                reward: "maghrib_sunnah_reward"),
        ]
    }

    static let aishaa: (Int64) -> [ANSunnahDAO] = {
        [
            .init(
                name: "aishaa",
                isDone: false,
                raqaat: 2,
                position: .before,
                affirmation: .desirable,
                prayerId: $0,
                reward: "ishaa_sunnah_reward"),
            .init(
                name: "aishaa",
                isDone: false,
                raqaat: 2,
                position: .after,
                affirmation: .affirmed,
                prayerId: $0,
                reward: "ishaa_sunnah_reward"),
        ]
    }
}
