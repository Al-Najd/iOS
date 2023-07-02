//
//  File.swift
//
//
//  Created by Ahmed Ramy on 27/03/2023.
//


import Foundation
import GRDB


// MARK: - ANAzkarTimedDAO

public struct AzkarTimedDAO: Codable {
    public var id: Int64?
    public var name: String
    public var reward: String
    public var repetation: Int
    public var time: Time
    public var currentCount: Int
    public var dayId: Int64
    public var isDone: Bool

    init(id: Int64? = nil, name: String, reward: String, time: Time, repetation: Int, dayId: Int64, isDone: Bool) {
        self.id = id
        self.name = name
        self.reward = reward
        self.time = time
        self.repetation = repetation
        currentCount = repetation
        self.dayId = dayId
        self.isDone = isDone
    }
}

extension AzkarTimedDAO {
    func toDomainModel() -> Zekr {
        Zekr(id: id!, name: name, reward: reward, repetation: repetation, currentCount: currentCount)
    }
}

// MARK: ANAzkarTimedDAO.Time

public extension AzkarTimedDAO {
    enum Time: Int, Codable, DatabaseValueConvertible {
        case day = 0
        case night = 1
    }
}

// MARK: TableRecord, EncodableRecord

extension AzkarTimedDAO: TableRecord, EncodableRecord {
    static let day = belongsTo(DayDAO.self)

    public static var databaseTableName = "azkar-timed"

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let reward = Column(CodingKeys.reward)
        static let repetation = Column(CodingKeys.repetation)
        static let time = Column(CodingKeys.time)
        static let currentCount = Column(CodingKeys.currentCount)
        static let dayId = Column(CodingKeys.dayId)
        static let isDone = Column(CodingKeys.isDone)
    }
}
