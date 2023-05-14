//
//  File.swift
//
//
//  Created by Ahmed Ramy on 09/10/2022.
//

import Foundation
import GRDB
import SwiftDate

// MARK: - DatabaseService

public enum DatabaseService {
    static let dbQueue: DatabaseQueue = try! {
        let fileManager = FileManager.default
        let dbPath = try fileManager
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("alnajd.sqlite3")
            .path

        print(dbPath)

        if !fileManager.fileExists(atPath: dbPath) {
            let dbResourcePath = Bundle.module.path(forResource: "alnajd", ofType: "sqlite3")!
            try fileManager.copyItem(atPath: dbResourcePath, toPath: dbPath)
        }

        return try DatabaseQueue(path: dbPath)
    }()

    private static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        #if DEBUG
        // Speed up development by nuking the database when migrations change
        // See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md#the-erasedatabaseonschemachange-option
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        migrator.registerMigration("createDays") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables
            try db.create(table: "days") {
                $0.autoIncrementedPrimaryKey("id")
                $0.column("date", .date).notNull()
            }
        }

        migrator.registerMigration("createPrayers") { db in
            try db.create(table: "prayers") {
                $0.autoIncrementedPrimaryKey("id")
                $0.column("name", .text).notNull()
                $0.column("reward", .text).notNull()
                $0.column("isDone", .boolean).notNull().defaults(to: false)
                $0.column("raqaat", .integer).notNull()
                $0.column("dayId", .integer).notNull().indexed().references("days", onDelete: .cascade)
            }
        }

        migrator.registerMigration("createSunnah") { db in
            try db.create(table: "sunnah") {
                $0.autoIncrementedPrimaryKey("id")
                $0.column("name", .text).notNull()
                $0.column("reward", .text).notNull()
                $0.column("isDone", .boolean).notNull().defaults(to: false)
                $0.column("raqaat", .integer).notNull()
                $0.column("position", .integer).notNull()
                $0.column("affirmation", .integer).notNull()
                $0.column("prayerId", .integer).notNull().indexed().references("prayers", onDelete: .cascade)
            }
        }

        migrator.registerMigration("createAzkar") { db in
            try db.create(table: "azkar") {
                $0.autoIncrementedPrimaryKey("id")
                $0.column("name", .text).notNull()
                $0.column("reward", .text).notNull()
                $0.column("repetation", .integer).notNull()
                $0.column("currentCount", .integer).notNull()
                $0.column("prayerId", .integer).notNull().indexed().references("prayers", onDelete: .cascade)
            }
        }

        migrator.registerMigration("createAzkarTimed") { db in
            try db.create(table: "azkar-timed") {
                $0.autoIncrementedPrimaryKey("id")
                $0.column("name", .text).notNull()
                $0.column("reward", .text).notNull()
                $0.column("repetation", .integer).notNull()
                $0.column("time", .integer).notNull()
                $0.column("currentCount", .integer).notNull()
                $0.column("isDone", .boolean).notNull()
                $0.column("dayId", .integer).notNull().indexed().references("days", onDelete: .cascade)
            }
        }

        migrator.registerMigration("createNafila") { db in
            try db.create(table: ANNafilaDAO.databaseTableName, body: {
                $0.autoIncrementedPrimaryKey("id")
                $0.column("name", .text).notNull()
                $0.column("reward", .text).notNull()
                $0.column("raqaatCount", .integer).notNull()
                $0.column("raqaat", .integer).notNull()
                $0.column("isDone", .boolean).notNull()
                $0.column("dayId", .integer).notNull().indexed().references("days", onDelete: .cascade)
            })
        }

        return migrator
    }

    public static func setupSchemes() {
        do {
            try migrator.migrate(dbQueue)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }

    public static func seedDatabase() {
        do {
            try seed()
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}

private extension DatabaseService {
    static func seed() throws {
        let date = Date().startOfDay
        try dbQueue.write { db in
            let day = try ANDayDAO(date: date).insertAndFetch(db)
            try seedPrayers((day?.id)!, db)
            try seedTimedAzkar((day?.id)!, db)
            try seedNafila((day?.id)!, db)
        }
    }

    static func seedNafila(_ dayId: Int64, _ db: Database) throws {
        _ = try ANNafilaDAO.subh(dayId).insertAndFetch(db)
        _ = try ANNafilaDAO.duha(dayId).insertAndFetch(db)
        _ = try ANNafilaDAO.shafaa(dayId).insertAndFetch(db)
        _ = try ANNafilaDAO.watr(dayId).insertAndFetch(db)
        _ = try ANNafilaDAO.qeyam(dayId).insertAndFetch(db)
    }

    static func seedPrayers(_ dayId: Int64, _ db: Database) throws {
        let fajr = try ANPrayerDAO(name: "fajr", isDone: false, raqaat: 2, dayId: dayId, reward: "fajr_reward").insertAndFetch(db)
        let dhuhr = try ANPrayerDAO(name: "duhr", isDone: false, raqaat: 4, dayId: dayId, reward: "duhr_reward")
            .insertAndFetch(db)
        let aasr = try ANPrayerDAO(name: "aasr", isDone: false, raqaat: 4, dayId: dayId, reward: "aasr_reward").insertAndFetch(db)
        let maghrib = try ANPrayerDAO(name: "maghrib", isDone: false, raqaat: 3, dayId: dayId, reward: "maghrib_reward")
            .insertAndFetch(db)
        let aishaa = try ANPrayerDAO(name: "aishaa", isDone: false, raqaat: 4, dayId: dayId, reward: "ishaa_reward")
            .insertAndFetch(db)

        try seedFajrSunnahAndAzkar((fajr?.id)!, db)
        try seedAasrAzkar((aasr?.id)!, db)
        try seedDhuhrSunnahAndAzkar((dhuhr?.id)!, db)
        try seedMaghribSunnahAndAzkar((maghrib?.id)!, db)
        try seedAishaaSunnahAndAzkar((aishaa?.id)!, db)

    }

    static func seedTimedAzkar(_ dayId: Int64, _ db: Database) throws {
        try ANAzkarTimedDAO.seedMorningAzkar(dayId, db)
        try ANAzkarTimedDAO.seedNightAzkar(dayId, db)
    }

    static func seedFajrSunnahAndAzkar(_ prayerId: Int64, _ db: Database) throws {
        _ = try ANSunnahDAO.fajr(prayerId).insertAndFetch(db)
        try (
            ANAzkarDAO.common(prayerId) +
                ANAzkarDAO.fajrAndMaghrib(prayerId)).forEach { _ = try $0.insertAndFetch(db) }
    }

    static func seedAasrAzkar(_ prayerId: Int64, _ db: Database) throws {
        try (ANAzkarDAO.common(prayerId) + ANAzkarDAO.sewar(prayerId)).forEach { _ = try $0.insertAndFetch(db) }
    }

    static func seedDhuhrSunnahAndAzkar(_ prayerId: Int64, _ db: Database) throws {
        try ANSunnahDAO.dhuhr(prayerId).forEach { _ = try $0.insertAndFetch(db) }
        try (ANAzkarDAO.common(prayerId) + ANAzkarDAO.sewar(prayerId)).forEach { _ = try $0.insertAndFetch(db) }
    }

    static func seedMaghribSunnahAndAzkar(_ prayerId: Int64, _ db: Database) throws {
        try ANSunnahDAO.maghrib(prayerId).forEach { _ = try $0.insertAndFetch(db) }
        try (ANAzkarDAO.common(prayerId) + ANAzkarDAO.fajrAndMaghrib(prayerId)).forEach { _ = try $0.insertAndFetch(db) }
    }

    static func seedAishaaSunnahAndAzkar(_ prayerId: Int64, _ db: Database) throws {
        try ANSunnahDAO.aishaa(prayerId).forEach { _ = try $0.insertAndFetch(db) }
        try (ANAzkarDAO.common(prayerId) + ANAzkarDAO.sewar(prayerId)).forEach { _ = try $0.insertAndFetch(db) }
    }
}

extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}
