//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/03/2023.
//


import Foundation
import GRDB


// MARK: - ANDayDAO

public struct DayDAO {
    public var id: Int64?
    public var date: Date
}

extension DayDAO {
    func toDomainModel(_ db: Database) throws -> Day {
        .init(
            id: Int(id!),
            date: date,
            prayers: .init(uniqueElements: try prayers.fetchAll(db).map { try $0.toDomainModel(db) }),
            morningAzkar: .init(uniqueElements: try morningAzkar.fetchAll(db).map { $0.toDomainModel() }),
            nightAzkar: .init(uniqueElements: try nightAzkar.fetchAll(db).map { $0.toDomainModel() })
        )
    }
}

// MARK: Codable, FetchableRecord, MutablePersistableRecord

extension DayDAO: Codable, FetchableRecord, MutablePersistableRecord { }

// MARK: TableRecord, EncodableRecord

extension DayDAO: TableRecord, EncodableRecord {
    public static var databaseTableName = "days"

    static let prayers = hasMany(PrayerDAO.self)
    static let sunnah = hasMany(SunnahDAO.self, through: prayers, using: PrayerDAO.sunnah)
    static let azkar = hasMany(AzkarDAO.self, through: prayers, using: PrayerDAO.azkar)
    static let timedAzkar = hasMany(AzkarTimedDAO.self)
    static let nafila = hasMany(ANNafilaDAO.self)

    enum Columns {
        static let id = Column(CodingKeys.id)
        static let date = Column(CodingKeys.date)
    }

    enum Queries {
        static var currentWeek: QueryInterfaceRequest<DayDAO> {
            DayDAO.filter(
                Columns.date <= Date().dateAtStartOf(.day) &&
                Columns.date >= Date().dateAtStartOf(.day).adding(.day, value: -6)
            )
        }

        static var previousWeek: QueryInterfaceRequest<DayDAO> {
            DayDAO.filter(
                Columns.date <= Date().dateAtStartOf(.day).adding(.day, value: -6) &&
                Columns.date >= Date().dateAtStartOf(.day).adding(.day, value: -13)
            )
        }

        static var beforeToday: QueryInterfaceRequest<DayDAO> {
            DayDAO.filter(
                Columns.date <= Date().dateAtStartOf(.day)
            )
        }

        static var today: QueryInterfaceRequest<DayDAO> {
            DayDAO.filter(Columns.date == Date().dateAtStartOf(.day))
        }

        static var todayPrayers: QueryInterfaceRequest<PrayerDAO> {
            today.including(all: prayers).asRequest(of: PrayerDAO.self)
        }

        static var withMissedPrayers: QueryInterfaceRequest<PrayerDAO> {
            DayDAO.including(all: prayers).asRequest(of: PrayerDAO.self).filter(PrayerDAO.Columns.isDone == false)
        }

        static var previousWeekWithDoneSunnah: QueryInterfaceRequest<DayDAO> {
            previousWeek.including(all: sunnah.filter(SunnahDAO.Columns.isDone == true))
        }

        static func getDay(for date: Date) -> QueryInterfaceRequest<DayDAO> {
            DayDAO.filter(Columns.date == date.startOfDay)
        }

        static func getPrayers(for date: Date) -> QueryInterfaceRequest<DayDAO> {
            getDay(for: date)
        }

        static func getAzkar(for date: Date) -> QueryInterfaceRequest<DayDAO> {
            getDay(for: date)
        }

        static func getNafila(for date: Date) -> QueryInterfaceRequest<DayDAO> {
            getDay(for: date)
        }

        private static func getTimedAzkar(for date: Date) -> QueryInterfaceRequest<DayDAO> {
            getDay(for: date)
        }

        static func getMorningAzkar(for date: Date) -> QueryInterfaceRequest<DayDAO> {
            getTimedAzkar(for: date).filter(AzkarTimedDAO.Columns.time == AzkarTimedDAO.Time.day)
        }

        static func getNightAzkar(for date: Date) -> QueryInterfaceRequest<DayDAO> {
            getTimedAzkar(for: date).filter(AzkarTimedDAO.Columns.time == AzkarTimedDAO.Time.night)
        }
    }

    var nafila: QueryInterfaceRequest<ANNafilaDAO> {
        request(for: Self.nafila)
    }

    var prayers: QueryInterfaceRequest<PrayerDAO> {
        request(for: Self.prayers)
    }

    var sunnah: QueryInterfaceRequest<SunnahDAO> {
        request(for: Self.sunnah)
    }

    var azkar: QueryInterfaceRequest<AzkarDAO> {
        request(for: Self.azkar)
    }

    var timedAzkar: QueryInterfaceRequest<AzkarTimedDAO> {
        request(for: Self.timedAzkar)
    }

    var morningAzkar: QueryInterfaceRequest<AzkarTimedDAO> {
        timedAzkar.filter(AzkarTimedDAO.Columns.time == AzkarTimedDAO.Time.day)
    }

    var nightAzkar: QueryInterfaceRequest<AzkarTimedDAO> {
        timedAzkar.filter(AzkarTimedDAO.Columns.time == AzkarTimedDAO.Time.night)
    }

    var donePrayers: QueryInterfaceRequest<PrayerDAO> {
        prayers.filter(PrayerDAO.Columns.isDone)
    }

    var doneSunnah: QueryInterfaceRequest<SunnahDAO> {
        sunnah.filter(SunnahDAO.Columns.isDone == true)
    }

    var doneAzkar: QueryInterfaceRequest<AzkarDAO> {
        azkar.filter(AzkarDAO.Columns.currentCount == 0)
    }

    var missedPrayers: QueryInterfaceRequest<PrayerDAO> {
        prayers.filter(PrayerDAO.Columns.isDone == false)
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
