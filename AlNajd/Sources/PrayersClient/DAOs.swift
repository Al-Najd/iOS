//
//  File.swift
//
//
//  Created by Ahmed Ramy on 09/10/2022.
//

import Entities
import Foundation
import GRDB
import Utils

public struct ANDayDAO {
    public var id: Int64?
    public var date: Date
}

public struct ANPrayerDAO {
    public var id: Int64?
    public var name: String
    public var isDone: Bool
    public var raqaat: Int
    public var dayId: Int64
    public var reward: String
}

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

public struct ANAzkarDAO {
    public var id: Int64?
    public var name: String
    public var reward: String
    public var repetation: Int
    public var currentCount: Int
    public var isDone: Bool { currentCount == .zero }
    public var prayerId: Int64?
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

extension ANPrayerDAO {
    func toDomainModel(sunnah: [ANSunnah], azkar: [ANAzkar]) -> ANPrayer {
        .init(
            id: id!,
            name: name,
            raqaat: raqaat,
            sunnah: .init(uniqueElements: sunnah),
            afterAzkar: .init(uniqueElements: azkar),
            isDone: isDone,
            reward: reward
        )
    }
}

extension ANSunnahDAO {
    func toDomainModel() -> ANSunnah {
        .init(
            id: id!,
            name: name,
            raqaat: raqaat,
            position: position.toDomainModel(),
            affirmation: affirmation.toDomainModel(),
            azkar: [],
            isDone: isDone,
            reward: reward
        )
    }
}

extension ANSunnahDAO.Position {
    func toDomainModel() -> ANSunnah.Position {
        switch self {
        case .before: return .before
        case .after: return .after
        }
    }
}

extension ANSunnahDAO.Affirmation {
    func toDomainModel() -> ANSunnah.Affirmation {
        switch self {
        case .affirmed: return .affirmed
        case .desirable: return .desirable
        }
    }
}

extension ANAzkarDAO {
    func toDomainModel() -> ANAzkar {
        .init(
            id: id!,
            name: name,
            reward: reward,
            repetation: repetation,
            currentCount: currentCount
        )
    }
}

extension ANDayDAO: Codable, FetchableRecord, MutablePersistableRecord {}

extension ANDayDAO: TableRecord, EncodableRecord {
    public static var databaseTableName: String = "days"

    static let prayers = hasMany(ANPrayerDAO.self)
    static let sunnah = hasMany(ANSunnahDAO.self, through: prayers, using: ANPrayerDAO.sunnah)
    static let azkar = hasMany(ANAzkarDAO.self, through: prayers, using: ANPrayerDAO.azkar)

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let date = Column(CodingKeys.date)
    }

    enum Queries {
        static var today: QueryInterfaceRequest<ANDayDAO> {
            ANDayDAO.filter(Columns.date == Date().startOfDay)
        }

        static var previousWeek: QueryInterfaceRequest<ANDayDAO> {
            ANDayDAO.filter(Date().startOfDay.previousWeek.contains(ANDayDAO.Columns.date))
        }

        var withMissedPrayers: QueryInterfaceRequest<ANPrayerDAO> {
            ANDayDAO.including(all: prayers).asRequest(of: ANPrayerDAO.self).filter(ANPrayerDAO.Columns.isDone == false)
        }

        static var previousWeekWithDoneSunnah: QueryInterfaceRequest<ANDayDAO> {
            previousWeek.including(all: sunnah.filter(ANSunnahDAO.Columns.isDone == true))
        }

        static func getPrayers(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
            ANDayDAO.filter(Columns.date == date.startOfDay)
        }
    }

    var prayers: QueryInterfaceRequest<ANPrayerDAO> {
        request(for: Self.prayers)
    }

    var sunnah: QueryInterfaceRequest<ANSunnahDAO> {
        request(for: Self.sunnah)
    }

    var azkar: QueryInterfaceRequest<ANAzkarDAO> {
        request(for: Self.azkar)
    }

    var donePrayers: QueryInterfaceRequest<ANPrayerDAO> {
        prayers.filter(ANPrayerDAO.Columns.isDone)
    }

    var doneSunnah: QueryInterfaceRequest<ANSunnahDAO> {
        sunnah.filter(ANSunnahDAO.Columns.isDone == true)
    }

    var doneAzkar: QueryInterfaceRequest<ANAzkarDAO> {
        azkar.filter(ANAzkarDAO.Columns.currentCount == 0)
    }

    var missedPrayers: QueryInterfaceRequest<ANPrayerDAO> {
        prayers.filter(ANPrayerDAO.Columns.isDone == false)
    }
}

extension ANPrayerDAO: Codable, FetchableRecord, MutablePersistableRecord {}

extension ANPrayerDAO: TableRecord, EncodableRecord {
    static let day = belongsTo(ANDayDAO.self)
    static let sunnah = hasMany(ANSunnahDAO.self)
    static let azkar = hasMany(ANAzkarDAO.self)

    public static var databaseTableName: String = "prayers"

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let isDone = Column(CodingKeys.isDone)
        static let raqaat = Column(CodingKeys.raqaat)
        static let dayId = Column(CodingKeys.dayId)
    }

    var day: QueryInterfaceRequest<ANDayDAO> {
        request(for: Self.day)
    }

    var doneFaraaid: QueryInterfaceRequest<ANPrayerDAO> {
        ANPrayerDAO.filter(Columns.isDone == true)
    }

    var sunnah: QueryInterfaceRequest<ANSunnahDAO> {
        request(for: Self.sunnah)
    }

    var doneSunnah: QueryInterfaceRequest<ANSunnahDAO> {
        sunnah.filter(ANSunnahDAO.Columns.isDone == true)
    }

    var azkar: QueryInterfaceRequest<ANAzkarDAO> {
        request(for: Self.azkar)
    }
}

extension ANSunnahDAO: Codable, FetchableRecord, MutablePersistableRecord {}

extension ANSunnahDAO: TableRecord, EncodableRecord {
    static let prayer = belongsTo(ANPrayerDAO.self)
    static let day = hasOne(ANDayDAO.self, through: prayer, using: ANPrayerDAO.day)

    public static var databaseTableName: String = "sunnah"

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

    var day: QueryInterfaceRequest<ANDayDAO> {
        request(for: Self.day)
    }
}

extension ANSunnahDAO {
    static let fajr: (Int64) -> ANSunnahDAO = {
        .init(name: "fajr", isDone: false, raqaat: 2, position: .before, affirmation: .affirmed, prayerId: $0, reward: "fajr_sunnah_reward")
    }

    static let dhuhr: (Int64) -> [ANSunnahDAO] = {
        [
            .init(name: "duhr", isDone: false, raqaat: 4, position: .before, affirmation: .affirmed, prayerId: $0, reward: "duhr_sunnah_reward"),
            .init(name: "duhr", isDone: false, raqaat: 2, position: .after, affirmation: .affirmed, prayerId: $0, reward: "duhr_sunnah_reward"),
            .init(name: "duhr", isDone: false, raqaat: 2, position: .after, affirmation: .desirable, prayerId: $0, reward: "duhr_sunnah_reward"),
        ]
    }

    static let maghrib: (Int64) -> [ANSunnahDAO] = {
        [
            .init(name: "maghrib", isDone: false, raqaat: 2, position: .before, affirmation: .desirable, prayerId: $0, reward: "maghrib_sunnah_reward"),
            .init(name: "maghrib", isDone: false, raqaat: 2, position: .after, affirmation: .affirmed, prayerId: $0, reward: "maghrib_sunnah_reward"),
        ]
    }

    static let aishaa: (Int64) -> [ANSunnahDAO] = {
        [
            .init(name: "aishaa", isDone: false, raqaat: 2, position: .before, affirmation: .desirable, prayerId: $0, reward: "ishaa_sunnah_reward"),
            .init(name: "aishaa", isDone: false, raqaat: 2, position: .after, affirmation: .affirmed, prayerId: $0, reward: "ishaa_sunnah_reward"),
        ]
    }
}

extension ANAzkarDAO: Codable, FetchableRecord, MutablePersistableRecord {}
extension ANAzkarDAO: TableRecord, EncodableRecord {
    static let prayer = belongsTo(ANPrayerDAO.self)

    public static var databaseTableName: String = "azkar"

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let reward = Column(CodingKeys.reward)
        static let repetation = Column(CodingKeys.repetation)
        static let currentCount = Column(CodingKeys.currentCount)
    }
}

extension ANAzkarDAO {
    static let common: (Int64) -> [ANAzkarDAO] = {
        [
            .init(name: "estigphar", reward: "", repetation: 3, currentCount: 3, prayerId: $0),
            .init(name: "ant_al_salam", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
            .init(name: "mokhlseen_laho_l_deen", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
            .init(name: "la_mani3_lema_a3tyt", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
            .init(name: "subhan_allah", reward: "", repetation: 33, currentCount: 33, prayerId: $0),
            .init(name: "alhamdulellah", reward: "", repetation: 33, currentCount: 33, prayerId: $0),
            .init(name: "allahuakbar", reward: "", repetation: 33, currentCount: 33, prayerId: $0),
            .init(name: "la_ilah_ila_allah", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
            .init(name: "la_ilah_ila_allah_la_hawl_wala_qwata_ila_bellah", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
        ]
    }

    static let fajrAndMaghrib: (Int64) -> [ANAzkarDAO] = {
        [
            .init(name: "la_ilah_ila_allah_wahdah", reward: "la_ilah_ila_allah_wahdah_reward", repetation: 10, currentCount: 10, prayerId: $0),
        ]
            +
            sewarFajrAndMaghrib($0)
    }

    static let sewar: (Int64) -> [ANAzkarDAO] = {
        [
            .init(name: "ayat_al_kursi", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
            .init(name: "ayat_al_ikhlas", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
            .init(name: "ayat_al_falaq", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
            .init(name: "ayat_al_alnas", reward: "", repetation: 1, currentCount: 1, prayerId: $0),
        ]
    }

    static let sewarFajrAndMaghrib: (Int64) -> [ANAzkarDAO] = {
        [
            .init(name: "ayat_al_kursi", reward: "", repetation: 3, currentCount: 3, prayerId: $0),
            .init(name: "ayat_al_ikhlas", reward: "", repetation: 3, currentCount: 3, prayerId: $0),
            .init(name: "ayat_al_falaq", reward: "", repetation: 3, currentCount: 3, prayerId: $0),
            .init(name: "ayat_al_alnas", reward: "", repetation: 3, currentCount: 3, prayerId: $0),
        ]
    }
}

extension ANPrayerDAO: Changeable {}
extension ANSunnahDAO: Changeable {}
extension ANAzkarDAO: Changeable {}
