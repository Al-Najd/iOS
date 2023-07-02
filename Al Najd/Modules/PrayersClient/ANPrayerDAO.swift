//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/03/2023.
//


import Foundation
import GRDB


// MARK: - ANPrayerDAO

public struct ANPrayerDAO {
    public var id: Int64?
    public var name: String
    public var isDone: Bool
    public var raqaat: Int
    public var dayId: Int64
    public var reward: String
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
            reward: reward)
    }
}

// MARK: Codable, FetchableRecord, MutablePersistableRecord

extension ANPrayerDAO: Codable, FetchableRecord, MutablePersistableRecord { }

// MARK: TableRecord, EncodableRecord

extension ANPrayerDAO: TableRecord, EncodableRecord {
    static let day = belongsTo(ANDayDAO.self)
    static let sunnah = hasMany(ANSunnahDAO.self)
    static let azkar = hasMany(ANAzkarDAO.self)

    public static var databaseTableName = "prayers"

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
