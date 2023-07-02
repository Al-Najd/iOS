//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import ComposableArchitecture
import Foundation
import GRDB

// MARK: - PrayersClient

public struct PrayersService {
    public func save(nafila: Nafila?) {
        guard let nafila = nafila else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try ANNafilaDAO.fetchOne(db, key: nafila.id)
                dao?.isDone = nafila.isDone
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    public func save(prayer: Prayer?) {
        guard let prayer = prayer else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try PrayerDAO.fetchOne(db, key: prayer.id)
                dao?.isDone = prayer.isDone
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    public func save(sunnah: Sunnah?) {
        guard let sunnah = sunnah else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try SunnahDAO.fetchOne(db, key: sunnah.id)
                dao?.isDone = sunnah.isDone
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    public func save(zekr: Zekr?) {
        guard let zekr = zekr else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try AzkarDAO.fetchOne(db, key: zekr.id)
                dao?.currentCount = zekr.currentCount
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    public func getCurrentWeek() -> [Day] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.currentWeek.fetchAll(db).map {
                    try $0.toDomainModel(db)
                }
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }

    public func getPreviousWeek() -> [Day] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.previousWeek.fetchAll(db).map {
                    try $0.toDomainModel(db)
                }
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }

    public func nafila(for date: Date) -> [Nafila] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try (DayDAO.Queries.getNafila(for: date).fetchOne(db)?.nafila.fetchAll(db))!.compactMap {
                    $0.toDomainModel()
                }
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }

    public func prayers(for date: Date) -> [Prayer] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.getPrayers(for: date).fetchOne(db)?.prayers.fetchAll(db).compactMap {
                    $0.toDomainModel(
                        sunnah: try $0.sunnah.fetchAll(db).map { $0.toDomainModel() },
                        azkar: try $0.azkar.fetchAll(db).map { $0.toDomainModel() })
                } ?? []
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }

    public func todayPrayers() -> [Prayer] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.todayPrayers.fetchAll(db).compactMap {
                    $0.toDomainModel(
                        sunnah: try $0.sunnah.fetchAll(db).map { $0.toDomainModel() },
                        azkar: try $0.azkar.fetchAll(db).map { $0.toDomainModel() })
                }
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }

    public func getPrayingStreak() -> Int {
        do {
            return try DatabaseService.dbQueue.read { db in
                // Get days from today till days where streak was broken
                let days = try DayDAO.Queries.beforeToday.including(all: DayDAO.prayers).all().fetchAll(db)
                let daysWithFullPrayers = try days.filter { try $0.missedPrayers.isEmpty(db) != false }
                return daysWithFullPrayers.count
            }
        } catch {
            Log.error(error.localizedDescription)
            return 0
        }
    }

    public func getFaraaidDone() -> Int {
        do {
            return try DatabaseService.dbQueue.read { db in
                try PrayerDAO.filter(PrayerDAO.Columns.isDone == true).fetchCount(db)
            }
        } catch {
            Log.error(error.localizedDescription)
            return 0
        }
    }

    public func getSunnahsPrayed() -> Int {
        do {
            return try DatabaseService.dbQueue.read { db in
                try SunnahDAO.filter(SunnahDAO.Columns.isDone == true).fetchCount(db)
            }
        } catch {
            Log.error(error.localizedDescription)
            return 0
        }
    }

    public func getAzkarDoneCount() -> Int {
        do {
            return try DatabaseService.dbQueue.read { db in
                try AzkarDAO.filter(AzkarDAO.Columns.currentCount == 0).fetchCount(db)
            }
        } catch {
            Log.error(error.localizedDescription)
            return 0
        }
    }

    public func getSunnahPerDay() -> [(date: Date, count: Int)] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.previousWeek.fetchAll(db).compactMap {
                    ($0.date, try $0.doneSunnah.fetchCount(db))
                }
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }
}

// MARK: DependencyKey

extension PrayersService: DependencyKey {
    public static let liveValue = PrayersService()
}

public extension DependencyValues {
    var prayersService: PrayersService {
        get { self[PrayersService.self] }
        set { self[PrayersService.self] = newValue }
    }
}
