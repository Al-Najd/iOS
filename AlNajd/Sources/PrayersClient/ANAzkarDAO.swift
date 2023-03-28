//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/03/2023.
//

import Entities
import Foundation
import GRDB
import Utils

// MARK: - ANAzkarDAO

public struct ANAzkarDAO {
    public var id: Int64?
    public var name: String
    public var reward: String
    public var repetation: Int
    public var currentCount: Int
    public var isDone: Bool { currentCount == .zero }
    public var prayerId: Int64?
}

extension ANAzkarDAO {
    func toDomainModel() -> ANAzkar {
        .init(
            id: id!,
            name: name,
            reward: reward,
            repetation: repetation,
            currentCount: currentCount)
    }
}

// MARK: - ANAzkarDAO + Codable, FetchableRecord, MutablePersistableRecord

extension ANAzkarDAO: Codable, FetchableRecord, MutablePersistableRecord { }

// MARK: - ANAzkarDAO + TableRecord, EncodableRecord

extension ANAzkarDAO: TableRecord, EncodableRecord {
    static let prayer = belongsTo(ANPrayerDAO.self)

    public static var databaseTableName = "azkar"

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
            .init(
                name: "la_ilah_ila_allah_la_hawl_wala_qwata_ila_bellah",
                reward: "",
                repetation: 1,
                currentCount: 1,
                prayerId: $0),
        ]
    }

    static let fajrAndMaghrib: (Int64) -> [ANAzkarDAO] = {
        [
            .init(
                name: "la_ilah_ila_allah_wahdah",
                reward: "la_ilah_ila_allah_wahdah_reward",
                repetation: 10,
                currentCount: 10,
                prayerId: $0),
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
