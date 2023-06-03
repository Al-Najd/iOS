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
    static let nafila = hasMany(ANNafilaDAO.self)

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let date = Column(CodingKeys.date)
    }

    enum Queries {
        static var today: QueryInterfaceRequest<ANDayDAO> {
            ANDayDAO.filter(Columns.date == Date().dateAtStartOf(.day))
        }

        static var todayPrayers: QueryInterfaceRequest<ANPrayerDAO> {
            today.including(all: prayers).asRequest(of: ANPrayerDAO.self)
        }

        static var previousWeek: QueryInterfaceRequest<ANDayDAO> {
            ANDayDAO.filter(Date().startOfDay.previousWeek.contains(ANDayDAO.Columns.date))
        }

        static var withMissedPrayers: QueryInterfaceRequest<ANPrayerDAO> {
            ANDayDAO.including(all: prayers).asRequest(of: ANPrayerDAO.self).filter(ANPrayerDAO.Columns.isDone == false)
        }

        static var previousWeekWithDoneSunnah: QueryInterfaceRequest<ANDayDAO> {
            previousWeek.including(all: sunnah.filter(ANSunnahDAO.Columns.isDone == true))
        }

        static func getDay(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
            ANDayDAO.filter(Columns.date == date.startOfDay)
        }

        static func getPrayers(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
            getDay(for: date)
        }

        static func getAzkar(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
            getDay(for: date)
        }

        static func getNafila(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
            getDay(for: date)
        }

        private static func getTimedAzkar(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
            getDay(for: date)
        }

        static func getMorningAzkar(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
            getTimedAzkar(for: date).filter(ANAzkarTimedDAO.Columns.time == ANAzkarTimedDAO.Time.day)
        }

        static func getNightAzkar(for date: Date) -> QueryInterfaceRequest<ANDayDAO> {
            getTimedAzkar(for: date).filter(ANAzkarTimedDAO.Columns.time == ANAzkarTimedDAO.Time.night)
        }
    }

    var nafila: QueryInterfaceRequest<ANNafilaDAO> {
        request(for: Self.nafila)
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

extension Date {
    func asDateSearchText() -> String {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en")
        formatter.timeZone = .current
        formatter.calendar = .current
        formatter.dateFormat = "YYYY-MM-DD HH:MM:SS"

        return formatter.string(from: self)
    }
}
