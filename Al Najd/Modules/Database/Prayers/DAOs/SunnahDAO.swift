//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/03/2023.
//


import Foundation
import GRDB


// MARK: - ANSunnahDAO

public struct SunnahDAO {
    public var id: Int64?
    public var name: String
    public var isDone: Bool
    public var raqaat: Int
    public var position: Position
    public var affirmation: Affirmation
    public var prayerId: Int64
    public var reward: String
}

public extension SunnahDAO {
    enum Affirmation: Int, Codable, DatabaseValueConvertible {
        case affirmed
        case desirable
    }

    enum Position: Int, Codable, DatabaseValueConvertible {
        case before
        case after
    }
}

extension SunnahDAO {
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

extension SunnahDAO.Position {
    func toDomainModel() -> Sunnah.Position {
        switch self {
        case .before: return .before
        case .after: return .after
        }
    }
}

extension SunnahDAO.Affirmation {
    func toDomainModel() -> Sunnah.Affirmation {
        switch self {
        case .affirmed: return .affirmed
        case .desirable: return .desirable
        }
    }
}

// MARK: - ANSunnahDAO + Codable, FetchableRecord, MutablePersistableRecord

extension SunnahDAO: Codable, FetchableRecord, MutablePersistableRecord { }

// MARK: - ANSunnahDAO + TableRecord, EncodableRecord

extension SunnahDAO: TableRecord, EncodableRecord {
    static let prayer = belongsTo(PrayerDAO.self)
    static let day = hasOne(DayDAO.self, through: prayer, using: PrayerDAO.day)

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
        static var fajr: QueryInterfaceRequest<SunnahDAO> {
            SunnahDAO.filter(Columns.name == "fajr")
        }
    }

    var prayer: QueryInterfaceRequest<PrayerDAO> {
        request(for: Self.prayer)
    }

    var day: QueryInterfaceRequest<DayDAO> {
        request(for: Self.day)
    }
}

// MARK: - Seedings
extension SunnahDAO {
    static let fajr: (Int64) -> SunnahDAO = {
        .init(
            name: "fajr",
            isDone: false,
            raqaat: 2,
            position: .before,
            affirmation: .affirmed,
            prayerId: $0,
            reward: "fajr_sunnah_reward")
    }

    static let dhuhr: (Int64) -> [SunnahDAO] = {
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

    static let maghrib: (Int64) -> [SunnahDAO] = {
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

    static let aishaa: (Int64) -> [SunnahDAO] = {
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
