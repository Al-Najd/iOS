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

// MARK: - ANDayDAO

public struct ANDayDAO {
    public var id: Int64?
    public var date: Date
}

// MARK: - ANDayDAO + Codable, FetchableRecord, MutablePersistableRecord

extension ANDayDAO: Codable, FetchableRecord, MutablePersistableRecord { }

// MARK: - ANDayDAO + TableRecord, EncodableRecord

extension ANDayDAO: TableRecord, EncodableRecord {
    public static var databaseTableName = "days"

    static let prayers = hasMany(ANPrayerDAO.self)
    static let sunnah = hasMany(ANSunnahDAO.self, through: prayers, using: ANPrayerDAO.sunnah)
    static let azkar = hasMany(ANAzkarDAO.self, through: prayers, using: ANPrayerDAO.azkar)
    static let timedAzkar = hasMany(ANAzkarTimedDAO.self)

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

        static func getAzkar(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
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

    var timedAzkar: QueryInterfaceRequest<ANAzkarTimedDAO> {
        request(for: Self.timedAzkar)
    }

    var morningAzkar: QueryInterfaceRequest<ANAzkarTimedDAO> {
        timedAzkar.filter(ANAzkarTimedDAO.Columns.time == ANAzkarTimedDAO.Time.day)
    }

    var nightAzkar: QueryInterfaceRequest<ANAzkarTimedDAO> {
        timedAzkar.filter(ANAzkarTimedDAO.Columns.time == ANAzkarTimedDAO.Time.night)
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
